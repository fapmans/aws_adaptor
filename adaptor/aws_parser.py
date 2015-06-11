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


def parse_action_entry(value, conds, rule):

    idx = value.find(":")
    if idx > 0:
        service = value[:idx]
        action = value[idx+1:]

        c = { "attribute": "action_service", "operator": "=", "value": service, "type": value_type(service) }

        if c not in conds:
            conds.append(c)
        rule = rule + "(c" + str(conds.index(c)) + " & " # Open ACTION_SERVICE + ACTION

    else:
        action = value

    c = { "attribute": "action", "operator": "=", "value": action, "type": value_type(action) }

    if c not in conds:
        conds.append(c)
    rule = rule + "c" + str(conds.index(c))
    if idx > 0:
        rule = rule + ")" # Closes ACTION_SERVICE + ACTION

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
            conds, rule = parse_action_entry(v, conds, rule)
            i = i + 1

    else:
        conds, rule = parse_action_entry(value, conds, rule)

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
        else:
            resp[type+'_type'] = v[:idx]
            resp[type] = v[idx+1:]
                
    return resp

def parse_resource_entry(value, conds, rule):
    if value[:4] == "arn:":
        values = parse_arn(value, "resource")

        j = 0
        for att, val in values.items():
            c = { "attribute": att, "operator": "=", "value": val, "type": value_type(val) }

            if c not in conds:
                conds.append(c)

            if j > 0:
                rule = rule + " & "
            rule = rule + "c" + str(conds.index(c))
            j += 1
    else:
        c = { "attribute": "resource", "operator": "=", "value": value, "type": value_type(value) }

        if c not in conds:
            conds.append(c)

        rule = rule + "c" + str(conds.index(c))

    return conds, rule

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
            conds, rule = parse_resource_entry(v, conds, rule)
            rule = rule + ")"
            i += 1
    else:
        conds, rule = parse_resource_entry(value, conds, rule)

    rule = rule + ")"

    return rule, conds

def parse_principal_entry(value, conds, rule):
    if value[:4] == "arn:":
        values = parse_arn(value, "principal")

        j = 0
        for att, val in values.items():
            c = { "attribute": att, "operator": "=", "value": val, "type": value_type(val) }

            if c not in conds:
                conds.append(c)

            if j > 0:
                rule = rule + " & "
            rule = rule + "c" + str(conds.index(c))
            j += 1
    else:
        c = { "attribute": "principal", "operator": "=", "value": value, "type": value_type(value) }

        if c not in conds:
            conds.append(c)

        rule = rule + "c" + str(conds.index(c))

    return conds, rule

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
        for principal_type, val in value.items():
            if i > 0:
                rule = rule + " | (" # Open Principal item
            else:
                rule = rule + "("    # Open Principal item

            # Create a Principal_Type condition
            c = { "attribute": "principal_type", "operator": "=", "value": principal_type, "type": value_type(principal_type) }

            if c not in conds:
                conds.append(c)
            rule = rule + "c" + str(conds.index(c))

            # Create Principal conditions
            if type(val) is list: # "Principal": {"AWS": ["arn:aws:iam::AWS-account-ID:user/user-name-1",  "arn:aws:iam::AWS-account-ID:user/UserName2" ]}
                j = 0
                for prin in val:
                    rule = rule + " & (" # Open Principal item value

                    conds, rule = parse_principal_entry(prin, conds, rule)

                    rule = rule + ")"        # Close Principal item value
                    j += 1

            else: # "Principal": {"AWS": "arn:aws:iam::AWS-account-ID:user/user-name"} | "Principal": {"AWS": "AWS-account-ID"}
                conds, rule = parse_principal_entry(val, conds, rule)

            rule = rule + ")" # Close Principal item
            i += 1

    else: # "Principal": "*"
        conds, rule = parse_principal_entry(value, conds, rule)

    rule = rule + ")" # Close Principal

    return rule, conds

def parse_condition_entry(att, op, val, conds, rule):
    c = { "attribute": att, "operator": op, "value": val, "type": value_type(val) }

    if c not in conds:
        conds.append(c)
    rule = rule + "c" + str(conds.index(c))
    
    return conds, rule

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
                    conds, rule = parse_condition_entry(att, op, vl, conds, rule)
                    i = i + 1
            else:
                conds, rule = parse_condition_entry(att, op, val, conds, rule)

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

def policy2local(dnf_policy):
    policy = {}
    if 'and_rules' in dnf_policy: # If there is no and_rules, just return an empty policy
        for and_rule in dnf_policy['and_rules']: # For each and_rule
            enabled = True
            if 'enabled' in and_rule:
                enabled = and_rule['enabled']
            if enabled:  # If it is enabled
                service = ""
                action  = ""
                condition = ""
                for cond in and_rule['conditions']:    # Check all Conditions
                    not_cond = ""
                    if 'operator' in cond:
                        if cond['operator'] == "!=":
                            not_cond = "not "
                    if 'attribute' in cond:
                        if cond['attribute'] == "service":    # Retrieve the Service
                            service = cond['value']
                        elif cond['attribute'] == "action":   # Retrieve the Action
                            action = cond['value']
                        else:                              # Retrieve the other Conditions (combining with "and"s)
                            if condition == "":
                                condition = not_cond + cond['attribute'] + ":" + cond['value']
                            else:
                                condition = condition + " and " + not_cond + cond['attribute'] + ":" + cond['value']
                    else:
                        print(cond)

                # Insert the and_rule in the policy
                if service+":"+action in policy:           # Set the policy entry. If already exists, combine with "or"s
                    if condition.find("and") == -1:
                        policy[service+":"+action] = policy[service+":"+action] + " or " + condition
                    else:
                        policy[service+":"+action] = policy[service+":"+action] + " or (" + condition + ")"
                else:
                    if condition.find("and") == -1:        # Includes the case: condition == ""
                        policy[service+":"+action] = condition
                    else:
                        policy[service+":"+action] = "(" + condition + ")"
    return policy
