from adaptor import aws_parser
from adaptor import semantic_parser
import json

def policy2dnf(policy, tenant, apf):
    resp = {}
    dnfpol = aws_parser.policy2dnf(policy)
    ontpol = semantic_parser.semantic2ontology(dnfpol, tenant, apf)
    if ontpol:
	    resp['dnf_policy'] = ontpol
    return resp

def policy2local(dnf_policy, tenant, apf):
    resp = {}
    locpol = semantic_parser.semantic2local(dnf_policy, tenant, apf)
    parsedpol = aws_parser.policy2local(locpol)
    if parsedpol:
	    resp['policy'] = parsedpol
    # resp['policy'] = locpol
    return resp
