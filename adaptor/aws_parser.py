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
                resp[type+'_connector'] = "/"
        else:
            resp[type+'_type'] = v[:idx]
            resp[type] = v[idx+1:]
            resp[type+'_connector'] = ":"
                
    return resp

def parse_resource(value, conds, rule, not_cond = False):
    nt = ""
    if not_cond:
        nt = "~"

    if rule != "":
        rule = rule + " & " + nt + "("
    else:
        rule = nt + "("

    if type(value) is list:
        i = 0
        for v in value:
            if i > 0:
                rule = rule + " | "
            rule = rule + "("
            conds, rule = parse_entry("resource", "=", v, conds, rule)
            rule = rule + ")"
            i += 1
    else:
        conds, rule = parse_entry("resource", "=", value, conds, rule)

    rule = rule + ")"

    return rule, conds

def parse_principal(value, conds, rule, not_cond = False):
    nt = ""
    if not_cond:
        nt = "~"

    if rule != "":
        rule = rule + " & " + nt + "(" # Open Principal
    else:
        rule = nt + "("                # Open Principal

    if type(value) is dict:
        i = 0
        for principal_origin, val in value.items():
            if i > 0:
                rule = rule + " | (" # Open Principal item
            else:
                rule = rule + "("    # Open Principal item

            # Create Principal conditions
            if type(val) is list: # "Principal": {"AWS": ["arn:aws:iam::AWS-account-ID:user/user-name-1",  "arn:aws:iam::AWS-account-ID:user/UserName2" ]}
                j = 0
                for prin in val:
                    if j == 0:
                        rule = rule + "(" # Open Principal item value
                    else:
                        rule = rule + " | (" # Open Principal item value

                    conds, rule = parse_entry("principal", "=", principal_origin+":"+prin, conds, rule)

                    rule = rule + ")"        # Close Principal item value
                    j += 1

            else: # "Principal": {"AWS": "arn:aws:iam::AWS-account-ID:user/user-name"} | "Principal": {"AWS": "AWS-account-ID"}
                conds, rule = parse_entry("principal", "=", principal_origin+":"+val, conds, rule)

            rule = rule + ")" # Close Principal item
            i += 1

    else: # "Principal": "*"
        conds, rule = parse_entry("principal", "=", value, conds, rule)

    rule = rule + ")" # Close Principal

    print (rule)

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

    # Positive rules
    if type == 'Principal' or type == 'NotPrincipal':

        principal = {}

        for cond in conditions:
            idx = cond['value'].find(":")
            print(cond)
            print(idx)
            if idx > 0:
                principal_origin = cond['value'][:idx]
                if principal_origin in principal:
                    if principal[principal_origin] is list:
                        principal[principal_origin].append(cond['value'][idx+1:])
                    else:
                        tmp = principal[principal_origin]
                        principal[principal_origin] = []
                        principal[principal_origin].append(tmp)
                        principal[principal_origin].append(cond['value'][idx+1:])
                else:
                    principal[principal_origin] = cond['value'][idx+1:]
                print(principal)
            else:
                principal = cond['value']

        resp = principal

    elif type == 'Resource' or type == 'NotResource':

        resource = ""

        for cond in conditions:
            if resource is list:
                resource.append(cond['value'])
            else:
                if resource != "":
                    tmp = resource
                    resource = []
                    resource.append(tmp)
                    resource.append(cond['value'])
                else:
                    resource = cond['value']

        resp = resource

    elif type == 'Action' or type == 'NotAction':

        action = ""

        for cond in conditions:
            if action is list:
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

    return policy
