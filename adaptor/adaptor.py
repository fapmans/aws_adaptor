from adaptor import aws_parser
from adaptor import semantic_parser
import json

def policy2dnf(policy, tenant, apf):
    resp = {}
    dnfpol = aws_parser.policy2dnf(policy)
    resp['dnf_policy'] = semantic_parser.semantic2ontology(dnfpol, tenant, apf)
    return resp

def policy2local(dnf_policy, tenant, apf):
    resp = {}
    locpol = semantic_parser.semantic2local(dnf_policy, tenant, apf)
    resp['policy'] = aws_parser.policy2local(locpol)
#    resp['policy'] = locpol
    return resp
