#!/bin/sh

# # 	{"id":1,"tenant":1,"apf":null,"ontology":false,"enumerated":true,"name":"role","description":"UFPE AWS role"}
# # 	{"id":2,"tenant":null,"apf":1,"ontology":true,"enumerated":true,"name":"user.role","description":"Ontology users role attribute"}
# # 	{"id":3,"tenant":null,"apf":null,"ontology":false,"enumerated":true,"name":"service","description":"AWS service"}
# # 	{"id":4,"tenant":null,"apf":null,"ontology":true,"enumerated":true,"name":"resource.service","description":"Service in which the Resource is contained"}
# # 	{"id":5,"tenant":null,"apf":null,"ontology":false,"enumerated":true,"name":"action","description":"Action in AWS Service"}
# # 	{"id":6,"tenant":null,"apf":null,"ontology":true,"enumerated":true,"name":"action.type","description":"Type of an Action"}
# # 	{"id":7,"tenant":null,"apf":null,"ontology":true,"enumerated":true,"name":"resource.type","description":"Type of a resource"}
# # 	{"id":8,"tenant":null,"apf":null,"ontology":true,"enumerated":true,"name":"action.parameter","description":"Parameter of an action"}.
# #   {"id":9,"tenant":null,"apf":null,"ontology":false,"enumerated":false,"name":"principal_user_id","description":"Identifier of the user"}
# #   {"id":10,"tenant":null,"apf":null,"ontology":true,"enumerated":false,"name":"user.id","description":"Identifier for users in the ontology"}
# #   {"id":11,"tenant":2,"apf":null,"ontology":false,"enumerated":true,"name":"role","description":"Roles at UKC"}

# # Values

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute":7,"name":"virtual_machine","description":"VM Resource"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute":7,"name":"virtual_network_interface","description":"VNIF Resource"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute":7,"name":"virtual_hard_disk","description":"VHD Resource"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute":7,"name":"snapshot","description":"VM Snapshot"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute":8,"name":"virtual_network_interface","description":"VNIF Parameter"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute":8,"name":"virtual_hard_disk","description":"VHD Parameter"}' \
    http://localhost:8002/value/

