from pyeda.inter import *
import json
import re
import copy



# Return the oposite operator
def oposite_operator(operator):
    if operator == "=":
        return "!="
    elif operator == "!=":
        return "="
    elif operator == ">":
        return "<="
    elif operator == "<":
        return ">="
    elif operator == ">=":
        return "<"
    elif operator == "<=":
        return ">"
    else:
        return "not "+operator

def value_type(value):
    if "*" in value or "?" in value:
        t = "w" 
    elif value.find("${") == 0 and value.rfind("}") == len(value) - 1 :
        t = "v"
    else:
        t = "c"

    return t

def parse_entry(att, op, val, conds, rule):
    c = { "attribute": att, "operator": op, "value": val, "type": value_type(val) }

    if c not in conds:
        conds.append(c)
    rule = rule + "c" + str(conds.index(c))
    
    return conds, rule

def parse_arn(value, type):

    resp = {}

    if value[:4] == "arn:":
        v = value[4:]
        idx = v.find(":")
        if v[:idx] != "":
            resp[type+'_partition'] = v[:idx]

        v = v[idx+1:]
        idx = v.find(":")
        if v[:idx] != "":
            resp[type+'_service'] = v[:idx]

        v = v[idx+1:]
        idx = v.find(":")
        if v[:idx] != "":
            resp[type+'_region'] = v[:idx]

        v = v[idx+1:]
        idx = v.find(":")
        if v[:idx] != "":
            resp[type+'_account'] = v[:idx]

        v = v[idx+1:]

        idx = v.find(":")
        if idx < 0:
            idx2 = v.find("/")
            if idx2 < 0:
                resp[type] = v
            else:
                resp[type+'_type'] = v[:idx2]
                resp[type] = v[idx2+1:]
        else:
            resp[type+'_type'] = v[:idx]
            resp[type] = v[idx+1:]
                
    return resp

def parse_resource(value, conds, rule, not_cond = False):
    nt = ""
    if not_cond:
        nt = "~"
    if rule != "":
        rule = rule + " & "
    rule = rule + nt + "(" # &(

    if type(value) is list:
        i = 0
        for v in value:
            if i > 0:
                rule = rule + " | "
            rule = rule + "(" # |(
            ########### Added to split ARN
            if v[:4] == "arn:":
                atts = parse_arn(v, "resource")
                j = 0
                for att, val in atts.items():
                    if j > 0:
                        rule = rule + " & "       
                    rule = rule + "(" # &(
                    conds, rule = parse_entry(att, "=", val, conds, rule)
                    rule = rule + ")" # &)
                    j += 1
            else:
                conds, rule = parse_entry("resource", "=", v, conds, rule) # "Resource": "*"
            #########
            rule = rule + ")" # |)
            i += 1
    else:
        ########### Added to split ARN
        if value[:4] == "arn:":
            atts = parse_arn(value, "resource")
            j = 0
            for att, val in atts.items():
                if j > 0:
                    rule = rule + " & "       
                rule = rule + "("
                conds, rule = parse_entry(att, "=", val, conds, rule)
                rule = rule + ")"
                j += 1
        else:
            conds, rule = parse_entry("resource", "=", value, conds, rule) # "Resource": "*"
        #########

    rule = rule + ")"

    return rule, conds

def parse_principal_entry(principal_origin, val, conds, rule):
    if principal_origin == "AWS":
        if val[:4] != "arn:":
            conds, rule = parse_entry("principal_account", "=", val, conds, rule)
        else:
            atts = parse_arn(val, "principal")
            if 'principal_account' in atts:
                conds, rule = parse_entry("principal_account", "=", atts['principal_account'], conds, rule)
            if 'principal' in atts and 'principal_type' in atts:
                if atts['principal_type'] == "user":
                    conds, rule = parse_entry("principal_user_name", "=", atts['principal'], conds, rule)
                elif atts['principal_type'] == "role" or atts['principal_type'] == "assumed_role":
                    conds, rule = parse_entry("principal_role", "=", atts['principal'], conds, rule)
    elif principal_origin == "Federated":
        if val[:4] != "arn:":
            conds, rule = parse_entry("principal_idp_url", "=", val, conds, rule)
        else:
            atts = parse_arn(val, "principal")
            if 'principal_account' in atts:
                conds, rule = parse_entry("principal_account", "=", atts['principal_account'], conds, rule)
            if 'principal' in atts and 'principal_type' in atts and atts['principal_type'] == "saml-provider":
                conds, rule = parse_entry("principal_idp_protocol", "=", "saml", conds, rule)
                conds, rule = parse_entry("principal_idp_name", "=", atts['principal'], conds, rule)
    elif principal_origin == "Service":
        conds, rule = parse_entry("principal_service", "=", val, conds, rule)
    elif principal_origin == "CanonicalUser":
        conds, rule = parse_entry("principal_user_id", "=", val, conds, rule)

    return conds, rule

def parse_principal(value, conds, rule, not_cond = False):
    nt = ""
    if not_cond:
        nt = "~"
    if rule != "":
        rule = rule + " & "
    rule = rule + nt + "(" # Open Principal

    if type(value) is dict:
        i = 0
        for principal_origin, val in value.items():
            if i > 0:
                rule = rule + " | (" # Open Principal item
            else:
                rule = rule + "("    # Open Principal item

            if type(val) is list: # "Principal": {"AWS": ["arn:aws:iam::AWS-account-ID:user/user-name-1",  "arn:aws:iam::AWS-account-ID:user/UserName2" ]}
                j = 0
                for v in val:
                    if j == 0:
                        rule = rule + "(" # Open Principal item value
                    else:
                        rule = rule + " | (" # Open Principal item value

                    conds, rule = parse_principal_entry(principal_origin, v, conds, rule)

                    rule = rule + ")"        # Close Principal item value
                    j += 1

            else: # "Principal": {"AWS": "arn:aws:iam::AWS-account-ID:user/user-name"} | "Principal": {"AWS": "AWS-account-ID"}
                conds, rule = parse_principal_entry(principal_origin, val, conds, rule)

            rule = rule + ")" # Close Principal item
            i += 1

    else: # "Principal": "*"
        conds, rule = parse_entry("principal", "=", value, conds, rule)

    rule = rule + ")" # Close Principal

    return rule, conds

def parse_action(value, conds, rule, not_cond = False):
    nt = ""
    if not_cond:
        nt = "~"

    if rule != "":
        rule = rule + " & " + nt + "("  # Open ACTION
    else:
        rule = nt + "("                 # Open ACTION

    if type(value) is list:
        i = 0
        for v in value:
            if i > 0:
                rule = rule + " | "
            conds, rule = parse_entry("action", "=", v, conds, rule)
            i = i + 1

    else:
        conds, rule = parse_entry("action", "=", value, conds, rule)

    rule = rule + ")" # Closes ACTION

    return rule, conds

def parse_condition(value, conds, rule):
    for op, v in value.items():
        for att, val in v.items():
            if rule != "":
                rule = rule + " & ("
            else:
                rule = "("

            if type(val) is list:
                i = 0
                for vl in val:
                    if (i > 0):
                        rule = rule + " | "
                    conds, rule = parse_entry(att, op, vl, conds, rule)
                    i = i + 1
            else:
                conds, rule = parse_entry(att, op, val, conds, rule)

            rule = rule + ")"

    return rule, conds

def merge_rules(allow_rules, deny_rules, conds):
    allow = ""
    deny = ""

    i = 0
    for rule in allow_rules:
        if i > 0:
            allow = allow + " | "
        allow = allow + "(" + rule + ")"
        i += 1

    i = 0
    for rule in deny_rules:
        if i > 0:
            deny = deny + " | "
        deny = deny + "(" + rule + ")"
        i += 1

    rules = ""
    if (allow == "" and deny != ""):
        rules = "~("+deny+")"
        #print ("DENY")
    elif (allow != "" and deny == ""):
        rules = allow
        #print ("ALLOW")
    elif (allow != "" and deny != ""):
        rules = "("+allow+") & ~("+deny+")"
        #print ("ALLOW+DENY")

    #print(rules)

    return rules

def parse(policy):

    conds = []
    allow_rules = []
    deny_rules = []

    # Parse rules in Statement
    # Actions, Resources, Principals, and Conditions are transformed into conditions (C1, C2, ...)
    # Conditions combined with AND connector in an and_rule
    for st in policy['Statement']:                                                         # Interate in the Statement
        rule = ""
        for attr, value in st.items():                                                         # For each statement...
            if attr == 'Action':                                                                     # According to the item type, parse it.
                rule, conds = parse_action(value, conds, rule, not_cond = False)
            elif attr == 'NotAction':
                rule, conds = parse_action(value, conds, rule, not_cond = True)
            elif attr == 'Resource':
                rule, conds = parse_resource(value, conds, rule, not_cond = False)
            elif attr == 'NotResource':
                rule, conds = parse_resource(value, conds, rule, not_cond = True)
            elif attr == 'Principal':
                rule, conds = parse_principal(value, conds, rule, not_cond = False)
            elif attr == 'NotPrincipal':
                rule, conds = parse_principal(value, conds, rule, not_cond = True)
            elif attr == 'Condition':
                rule, conds = parse_condition(value, conds, rule)
            # else, do nothing. (just ignore the item. eg: Sid.

        # If Effect is "Allow", rule is appended to the Allow_rules list (which is ORed)
        if st['Effect'] == "Allow":
            allow_rules.append(rule)

        # If Effect is "Deny", rule is appended to the Deny_rules list (which is ORed)
        elif st['Effect'] == "Deny":
            deny_rules.append(rule)

    #print (conds)
    #print (allow_rules)
    #print (deny_rules)

    # Finally, allow_rules and deny_rules are combined: Allow_rules AND NOT (Deny_rules)
    # The result is a string in terms of conditions (C1, C2, ...) to be transformed into DNF
    rules = merge_rules(allow_rules, deny_rules, conds)

    return conds, rules

def to_dnf(conds, rules):
    resp = ""

    # Define global variables for each condition as a boolean expression
    gbl = globals()
    for i in range(len(conds)):
        var = "c"+str(i)
        gbl[var] = exprvar(var)

    # Define expression based on subject rules and convert them to DNF
    resp = eval(rules).to_dnf()

    #print(resp)

    return resp

def policy2dnf(policy):

    # DNF JSON object
    dnf_policy = {}
    and_rules = []

    # Parses policy content.
    conds, rules = parse(policy)

    # Convert to DNF
    rules = to_dnf(conds, rules)

    #print(conds)
    #print(rules)

    r1 = str(rules).strip()
    r1 = re.sub(' ', '', r1)

    # Add the conditions
    if "Or(" == r1[0:3]:
        s = r1[3:-1]
        s = s.strip('And') # Remove the And in the beginning of the string
        ands = s.split(",And") # Split using the ,And
        count = 0
        for a in ands:
            # Construct the conditions
            cs = a.split(",")
            conditions = []
            for c in cs:
                c = re.sub('[,()c]','',c)
                not_cond = False                # Start considering not a negation
                if c[0] == "~":                 # If this is a negation
                    not_cond = True                   # Mark as negation
                    c = re.sub('~','',c)              # Remove the negation symbol (~)

                if (c != "") and c is not None:
                    c = int(float(c))
                    cd = copy.copy(conds[c])

                    if not_cond:
                        cd['operator'] = oposite_operator(cd['operator'])

                    cd['description'] = cd['attribute']+cd['operator']+cd['value']

                    conditions.append(cd)

            # Create the AND Rule
            data = {
                     "description": a+str(count),
                     "enabled": True,
                     "conditions": conditions
                   }
            and_rules.append(data)
            count = count + 1

    elif "And(" == r1[0:4]:
        s = r1[4:-1]

        # Construct the conditions
        cs = s.split(",")
        conditions = []
        for c in cs:
            c = re.sub('[,()c]','',c)
            not_cond = False                # Start considering not a negation
            if c[0] == "~":                 # If this is a negation
                not_cond = True                   # Mark as negation
                c = re.sub('~','',c)              # Remove the negation symbol (~)
            if (c != "") and c is not None:
                c = int(float(c))
                cd = copy.copy(conds[c])

                if not_cond:
                    cd['operator'] = oposite_operator(cd['operator'])

                cd['description'] = cd['attribute']+cd['operator']+cd['value']

                conditions.append(cd)
        # Insert the AND Rule
        data = {
                 "description": s,
                 "enabled": True,
                 "conditions": conditions
               }
        and_rules.append(data)

    else:
        print ("OTHER: Error!?")
        c = r1
        c = c.strip(',').strip('(').strip(')').strip('c')
        print(c)

    dnf_policy['and_rules'] = and_rules
    return dnf_policy

def create_statement_entry(conditions, type):
    resp = {}

    # ** - This statement is NOT correct, since lists uses to mean OR and in this case it means AND
    #      This will be FIXED by the remove_duplicate_entries function, which will split statements
    #      with multiple entries of the same type.

    if type == 'Principal' or type == 'NotPrincipal':

        principal = {}

        principal_origin = ""

        principal_count = 0
        principal_account_count = 0
	
        for cond in conditions:
            if cond['attribute'] == 'principal':
                principal['anonymous'] = cond['value']
            elif cond['attribute'] == 'principal_account':
                principal['account'] = cond['value']
            elif cond['attribute'] == 'principal_user_name':
                principal['user_name'] = cond['value']
            elif cond['attribute'] == 'principal_role':
                principal['role'] = cond['value']
            elif cond['attribute'] == 'principal_idp_name':
                principal['idp_name'] = cond['value']
            elif cond['attribute'] == 'principal_idp_protocol':
                principal['idp_protocol'] = cond['value']
            elif cond['attribute'] == 'principal_idp_url':
                principal['idp_url'] = cond['value']
            elif cond['attribute'] == 'principal_service':
                principal['service'] = cond['value']
            elif cond['attribute'] == 'principal_user_id':
                principal['user_id'] = cond['value']

        principal_item = {}

        principal_count = 0

        if 'anonymous' in principal:
            principal_item = principal['anonymous']
            principal_count += 1
        if 'account' in principal and 'user_name' in principal:
            principal_item['AWS'] = "arn:aws:iam::" + principal['account'] + ":user/" + principal['user_name']
            principal_count += 1
        if 'account' in principal and 'role' in principal:
            if principal['role'].find("/") < 0:
                principal_item['AWS'] = "arn:aws:iam::" + principal['account'] + ":role/" + principal['role']
            else:
                principal_item['AWS'] = "arn:aws:sts::" + principal['account'] + ":assumed_role/" + principal['role']
            principal_count += 1
        if 'idp_url' in principal:
            principal_item['Federated'] = principal['idp_url']
            principal_count += 1
        if 'account' in principal and 'idp_name' in principal and 'idp_protocol' in principal:
            if principal['idp_protocol'] == "saml":
                principal_item['Federated'] = "arn:aws:iam::" + principal['account'] + ":saml-provider/" + principal['idp_name']
                principal_count += 1
        if 'service' in principal:
            principal_item['Service'] = principal['service']
            principal_count += 1
        if 'user_id' in principal:
            principal_item['CanonicalUser'] = principal['user_id']
            principal_count += 1
        if 'account' in principal and not ('user_name' in principal or 'role' in principal or 'idp_name' in principal):
            principal_item['AWS'] = principal['account']
            principal_count += 1

        if principal_count > 1:
            principal_item = "ERROR! More than one principals combined by AND. Invalid Policy."

        resp = principal_item

    elif type == 'Resource' or type == 'NotResource':

        resource = {}

        resource_count = 0

        for cond in conditions:
            if cond['attribute'] == 'resource_partition':
                resource['partition'] = cond['value']
            elif cond['attribute'] == 'resource_service':
                resource['service'] = cond['value']
            elif cond['attribute'] == 'resource_region':
                resource['region'] = cond['value']
            elif cond['attribute'] == 'resource_account':
                resource['account'] = cond['value']
            elif cond['attribute'] == 'resource_type':
                resource['type'] = cond['value']
            elif cond['attribute'] == 'resource':
                resource['value'] = cond['value']
                resource_count += 1
            else:
                print(cond) # Unexpected condition!

        if 'partition' in resource or \
            'service' in resource or \
            'region' in resource or \
            'account' in resource or \
            'type' in resource:
            arn = "arn:"
            if 'partition' in resource:
                arn = arn + resource['partition'] + ":"
            else:
                arn = arn + ":"
            if 'service' in resource:
                arn = arn + resource['service'] + ":"
            else:
                arn = arn + ":"
            if 'region' in resource:
                arn = arn + resource['region'] + ":"
            else:
                arn = arn + ":"
            if 'account' in resource:
                arn = arn + resource['account'] + ":"
            else:
                arn = arn + ":"
            if 'type' in resource:
                arn = arn + resource['type']
                if 'service' in resource and resource['service'] in ['ec2','iam','s3','dynamodb']:
                    arn = arn + "/"
                else:
                    arn = arn + ":"
            if 'value' in resource:
                arn = arn + resource['value']
            else:
                arn = arn + "*"

            resource_item = arn

        else:
            resource_item = resource['value']

        # This code handles the case where two resources comes into a single statement.
        # This should never happen! Eg. Resource-Allow & NotResource-Deny, NotResource-Allow & Resource-Deny 
        '''resource = ""
        for cond in conditions:
            if resource is list: # **
                resource.append(cond['value'])
            else:
                if resource != "":
                    tmp = resource
                    resource = []
                    resource.append(tmp)
                    resource.append(cond['value'])
                else:
                    resource = cond['value']'''

        if resource_count > 1:
            resource_item = "ERROR! Two resources combined by AND. Invalid Policy."

        resp = resource_item

    elif type == 'Action' or type == 'NotAction':

        action = ""

        for cond in conditions:
            if action is list: # **
                action.append(cond['value'])
            else:
                if action != "":
                    tmp = action
                    action = []
                    action.append(tmp)
                    action.append(cond['value'])
                else:
                    action = cond['value']

        resp = action

    elif type == 'Condition':

        condition = {}

        for cond in conditions:
            op = cond['operator']
            attr = cond['attribute']
            value = cond['value']
            if op in condition:
                if attr in condition[op]:
                    if condition[op][attr] is list:
                        condition[op][attr].append(value)
                    else:
                        tmp = condition[op][attr]
                        condition[op][attr] = []
                        condition[op][attr].append(tmp)
                        condition[op][attr].append(value)
                else:
                    condition[op][attr] = value
            else:
                condition[op] = {}
                condition[op][attr] = value
                        
        resp = condition

    else: 
        print(cond)

    return resp

def remove_duplicate_entries(policy):

    # ** : Fixes the issue with multiple rules of the same type in the same statement (list means AND and not OR)

    #print(policy)    #{'Statement': [{'Action': '*', 'NotAction': ['iam:*', 'sts:*'], 'Resource': '*', 'Effect': 'Allow'}]}

    new_policy = []

    for statement in policy['Statement']:

        added = False

        if 'Action' in statement:
            if 'NotAction' in statement:
                st1 = {}
                st2 = {}
                for att, value in statement.items():
                    if att == 'Action':
                        st1[att] = value
                    elif att == 'NotAction':
                        st2['Action'] = value
                    elif att == 'Effect':
                        st1[att] = 'Allow'
                        st2[att] = 'Deny'
                    else:
                        st1[att] = value
                        st2[att] = value
                if st1 not in new_policy:
                    new_policy.append(st1)
                if st2 not in new_policy:
                    new_policy.append(st2)
                added = True

            if type(statement['Action']) is list: # **
                print("Error! Statement with two Actions! Not included.")
                print(statement)
                added = True
                
        if 'Resource' in statement:
            if 'NotResource' in statement:
                st1 = {}
                st2 = {}
                for att, value in statement.items():
                    if att == 'Resource':
                        st1[att] = value
                    elif att == 'NotResource':
                        st2['Resource'] = value
                    elif att == 'Effect':
                        st1[att] = 'Allow'
                        st2[att] = 'Deny'
                    else:
                        st1[att] = value
                        st2[att] = value
             
                if st1 not in new_policy:
                    new_policy.append(st1)
                if st2 not in new_policy:
                    new_policy.append(st2)
                added = True

            if type(statement['Resource']) is list: # **
                print("Error! Statement with two Resources! Not included.")
                print(statement)
                added = True

        if 'Principal' in statement:
            if 'NotPrincipal' in statement:
                st1 = {}
                st2 = {}
                for att, value in statement.items():
                    if att == 'Principal':
                        st1[att] = value
                    elif att == 'NotPrincipal':
                        st2['Principal'] = value
                    elif att == 'Effect':
                        st1[att] = 'Allow'
                        st2[att] = 'Deny'
                    else:
                        st1[att] = value
                        st2[att] = value
             
                if st1 not in new_policy:
                    new_policy.append(st1)
                if st2 not in new_policy:
                    new_policy.append(st2)
                added = True

            if type(statement['Principal']) is list: # **
                print("Error! Statement with two Principals! Not included.")
                print(statement)
                added = True

        if not added:
            if statement not in new_policy:
                new_policy.append(statement)

    return new_policy

def policy2local(dnf_policy):

    policy = {}

    policy['Statement'] = []

    if 'and_rules' in dnf_policy: # If there is no and_rules, just return an empty policy
        for and_rule in dnf_policy['and_rules']: # For each and_rule
            enabled = True
            if 'enabled' in and_rule:
                enabled = and_rule['enabled']
            if enabled:  # If it is enabled
                statement = {}
                for cond in and_rule['conditions']:    # Check all Conditions
                    if 'attribute' in cond:
                        if cond['attribute'].find("principal") == 0:    # Retrieve the Principal attributes
                            if cond['operator'] == "=":
                                if not 'Principal' in statement:
                                    statement['Principal'] = []
                                statement['Principal'].append(cond)
                            else:
                                if not 'NotPrincipal' in statement:
                                    statement['NotPrincipal'] = []
                                statement['NotPrincipal'].append(cond)

                        elif cond['attribute'].find("action") == 0:   # Retrieve the Action attributes
                            if cond['operator'] == "=":
                                if not 'Action' in statement:
                                    statement['Action'] = []
                                statement['Action'].append(cond)
                            else:
                                if not 'NotAction' in statement:
                                    statement['NotAction'] = []
                                statement['NotAction'].append(cond)

                        elif cond['attribute'].find("resource") == 0:   # Retrieve the Resource attributes
                            if cond['operator'] == "=":
                                if not 'Resource' in statement:
                                    statement['Resource'] = []
                                statement['Resource'].append(cond)
                            else:
                                if not 'NotResource' in statement:
                                    statement['NotResource'] = []
                                statement['NotResource'].append(cond)
                        else:                              # Retrieve the other Conditions (combining with "and"s)
                            if not 'Condition' in statement:
                                statement['Condition'] = []
                            statement['Condition'].append(cond)

                    else:
                        print(cond)

                # Insert the and_rule in the policy
                policy['Statement'].append(statement)

    for statement in policy['Statement']:
        for attr, conds in statement.items():
             statement[attr] = create_statement_entry(conds, attr)
        statement['Effect'] = 'Allow'

    policy = remove_duplicate_entries(policy)

    return policy
