#!/bin/sh

# Attributes

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"apf": null, "description": "UFPE AWS role", "enumerated": true, "name": "role", "ontology": false, "tenant": 1 }' \
    http://localhost:8002/attribute/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"apf": 1,    "description": "Ontology users role attribute", "enumerated": true, "name": "user.role", "ontology": true, "tenant": null }' \
    http://localhost:8002/attribute/


curl -v -X POST -H "Content-Type: application/json" \
    -d '{"apf": null, "description": "AWS service", "enumerated": true, "name": "service", "ontology": false, "tenant": null }' \
    http://localhost:8002/attribute/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"apf": null, "description": "Service in which the Resource is contained", "enumerated": true, "id": 4, "name": "resource.service", "ontology": true, "tenant": null }' \
    http://localhost:8002/attribute/


curl -v -X POST -H "Content-Type: application/json" \
    -d '{"apf": null, "description": "Action in AWS Service", "enumerated": true, "name": "action", "ontology": false, "tenant": null }' \
    http://localhost:8002/attribute/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"apf": null, "description": "Type of an Action", "enumerated": true, "name": "action.type", "ontology": true, "tenant": null }' \
    http://localhost:8002/attribute/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"apf": null, "description": "Type of a resource", "enumerated": true, "name": "resource.type", "ontology": true, "tenant": null }' \
    http://localhost:8002/attribute/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"apf": null, "description": "Parameter of an action", "enumerated": true, "name": "action.parameter", "ontology": true, "tenant": null }' \
    http://localhost:8002/attribute/


curl -v -X POST -H "Content-Type: application/json" \
-d '{"apf": null, "description": "Identifier of the user", "enumerated": false, "name": "principal_user_id", "ontology": false, "tenant": null }' \
    http://localhost:8002/attribute/

curl -v -X POST -H "Content-Type: application/json" \
-d '{"apf": null, "description": "Identifier for users in the ontology", "enumerated": false, "name": "user.id", "ontology": true, "tenant": null }' \ 
    http://localhost:8002/attribute/

curl -v -X POST -H "Content-Type: application/json" \
-d '{"apf": null, "description": "Identifier for users in the ontology", "enumerated": false, "name": "virtual_network_interface", "ontology": true, "tenant": null }' \ 
    http://localhost:8002/attribute/