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

def parse_action(value, conds, rule, not_cond = False):
    nt = ""
    if not_cond:
        nt = "!"

    if conds != []:
        rule = rule + " & " + nt + "("
    else:
        rule = nt + "("

    if type(value) is list:
        i = 0
        for v in value:
            t = "c"
            if "*" in v:
                t = "v"  # This is not a variable, but a wildcard
            c = { "attr": "Action", "op": "=", "value": v, "type": t }
            if c not in conds:
                conds.append(c)
            if i > 0:
                rule = rule + " | "
            rule = rule + "c" + str(conds.index(c))
            i = i + 1
    else:
        t = "c"
        if "*" in value:
            t = "v"  # This is not a variable, but a wildcard
        c = { "attr": "Action", "op": "=", "value": value, "type": t }
        if c not in conds:
            conds.append(c)
        rule = rule + "c" + str(conds.index(c))

    rule = rule + ")"

    return rule, conds

def parse_resource(value, conds, rule, not_cond = False):
    nt = ""
    if not_cond:
        nt = "!"

    if conds != []:
        rule = rule + " & " + nt + "("
    else:
        rule = nt + "("

    if type(value) is list:
        i = 0
        for v in value:
            t = "c"
            if "*" in v:
                t = "v"  # This is not a variable, but a wildcard
            c = { "attr": "Resource", "op": "=", "value": v, "type": t }
            if c not in conds:
                conds.append(c)
            if i > 0:
                rule = rule + " | "
            rule = rule + "c" + str(conds.index(c))
            i = i + 1
    else:
        t = "c"
        if "*" in value:
            t = "v"  # This is not a variable, but a wildcard
        c = { "attr": "Resource", "op": "=", "value": value, "type": t }
        if c not in conds:
            conds.append(c)
        rule = rule + "c" + str(conds.index(c))

    rule = rule + ")"
    return rule, conds

def parse_principal(value, conds, rule, not_cond = False):
    return rule, conds

def parse_condition(value, conds, rule):

    if conds != []:
        rule = rule + " & " + "("
    else:
        rule = "("

    for op, v in value.items():
        for att, val in v:
            if type(val) is list:
                pass
            else:
                t = "c"
                if "*" in val:
                    t = "v"  # This is not a variable, but a wildcard
        
                c = { "attr": "Resource", "op": "=", "value": value, "type": t }
                if c not in conds:
                    conds.append(c)
                rule = rule + "c" + str(conds.index(c))
                

    if type(value) is list:
        i = 0
        for v in value:
            t = "c"
            if "*" in v:
                t = "v"  # This is not a variable, but a wildcard
            c = { "attr": "Resource", "op": "=", "value": v, "type": t }
            if c not in conds:
                conds.append(c)
            if i > 0:
                rule = rule + " | "
            rule = rule + "c" + str(conds.index(c))
            i = i + 1
    else:

    rule = rule + ")"

    return rule, conds

def merge_rules(allow_rules, deny_rules, conds):
    return ""

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

        # If Effect is "Allow", rule is appended to the Allow_rules list (which is ORed)
        if st['Effect'] == "Allow":
            allow_rules.append(rule)

        # If Effect is "Deny", rule is appended to the Deny_rules list (which is ORed)
        elif st['Effect'] == "Deny":
            deny_rules.append(rule)

    print (conds)
    print (allow_rules)
    print (deny_rules)

    # Finally, allow_rules and deny_rules are combined: Allow_rules AND NOT (Deny_rules)
    # The result is a string in terms of conditions (C1, C2, ...) to be transformed into DNF
    rules = merge_rules(allow_rules, deny_rules, conds)

    return conds, rules

def to_dnf(conds, rules):
    # Define global variables for each condition as a boolean expression
    gbl = globals()
    for i in range(len(conds)):
        var = "c"+str(i)
        gbl[var] = exprvar(var)

    # Define expression based on subject rules and convert them to DNF
    for rk, rv in rules.items():
        gbl[rk] = eval(rv)
        rules[rk] = gbl[rk].to_dnf()

    return rules

def policy2dnf(policy):

    # DNF JSON object
    dnf_policy = {}
    and_rules = []

    # Parses policy content.
    conds, rules = parse(policy)

    return {}

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
