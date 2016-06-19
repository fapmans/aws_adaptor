#!/bin/sh

# Attribute Mapping

#   {"id":1,"tenant":1,"apf":null,"ontology":false,"enumerated":true,"name":"role","description":"UFPE AWS role"}
#   {"id":2,"tenant":null,"apf":1,"ontology":true,"enumerated":true,"name":"user.role","description":"Ontology users role attribute"}
#   {"id":3,"tenant":null,"apf":null,"ontology":false,"enumerated":true,"name":"service","description":"AWS service"}
#   {"id":4,"tenant":null,"apf":null,"ontology":true,"enumerated":true,"name":"resource.service","description":"Service in which the Resource is contained"}
#   {"id":5,"tenant":null,"apf":null,"ontology":false,"enumerated":true,"name":"action","description":"Action in AWS Service"}
#   {"id":6,"tenant":null,"apf":null,"ontology":true,"enumerated":true,"name":"action.type","description":"Type of an Action"}
#   {"id":7,"tenant":null,"apf":null,"ontology":true,"enumerated":true,"name":"resource.type","description":"Type of a resource"}
#   {"id":8,"tenant":null,"apf":null,"ontology":true,"enumerated":true,"name":"action.parameter","description":"Parameter of an action"}.
#   {"id":9,"tenant":null,"apf":null,"ontology":false,"enumerated":false,"name":"principal_user_id","description":"Identifier of the user"}
#   {"id":10,"tenant":null,"apf":null,"ontology":true,"enumerated":false,"name":"user.id","description":"Identifier for users in the ontology"}
#   {"id":11,"tenant":2,"apf":null,"ontology":false,"enumerated":true,"name":"role","description":"Roles at UKC"}

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"id":1,"local_attribute":1,"apf_attribute":2}' \
    http://localhost:8002/attribute_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"id":2,"local_attribute":3,"apf_attribute":4}' \
    http://localhost:8002/attribute_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"id":3,"local_attribute":5,"apf_attribute":6}' \
    http://localhost:8002/attribute_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"id":4,"local_attribute":5,"apf_attribute":7}' \
    http://localhost:8002/attribute_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"id":5,"local_attribute":5,"apf_attribute":8}' \
    http://localhost:8002/attribute_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"id":6,"local_attribute":9,"apf_attribute":10}' \
    http://localhost:8002/attribute_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"id":7,"local_attribute":11,"apf_attribute":2}' \
    http://localhost:8002/attribute_mapping/
