#!/bin/sh

# Value Mapping
 # {"id": 62, "attribute": 22, "name": "ec2", "description": "AWS Compute Service (for actions)"},
 # {"id": 63, "attribute": 3, "name": "ec2", "description": "AWS Compute Service (for Resources)"},
 # {"id": 81, "attribute": 4, "name": "compute_service", "description": "Ontology Compute Service"},

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":62,"apf_value":81}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":63,"apf_value":81}' \
    http://localhost:8002/value_mapping/


 # {"id": 64, "attribute": 5, "name": "BundleInstance", "description": "action=BundleInstance"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":64,"apf_value":18}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":64,"apf_value":82}' \
    http://localhost:8002/value_mapping/

 # {"id": 65, "attribute": 5, "name": "CreateNetworkInterface", "description": "action=CreateNetworkInterface"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":65,"apf_value":18}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":65,"apf_value":83}' \
    http://localhost:8002/value_mapping/

 # {"id": 66, "attribute": 5, "name": "DescribeInstances", "description": "action=DescribeInstances"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":66,"apf_value":19}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":66,"apf_value":82}' \
    http://localhost:8002/value_mapping/

 # {"id": 67, "attribute": 5, "name": "DescribeNetworkInterfaces", "description": "action=DescribeNetworkInterfaces"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":67,"apf_value":19}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":67,"apf_value":83}' \
    http://localhost:8002/value_mapping/

 # {"id": 68, "attribute": 5, "name": "ModifyInstanceAttribute", "description": "action=ModifyInstanceAttribute"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":68,"apf_value":22}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":68,"apf_value":82}' \
    http://localhost:8002/value_mapping/

 # {"id": 69, "attribute": 5, "name": "ModifyNetworkInterfaceAttribute", "description": "action=ModifyNetworkInterfaceAttribute"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":69,"apf_value":22}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":69,"apf_value":83}' \
    http://localhost:8002/value_mapping/

 # {"id": 70, "attribute": 5, "name": "TerminateInstances", "description": "action=TerminateInstances"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":70,"apf_value":21}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":70,"apf_value":82}' \
    http://localhost:8002/value_mapping/

 # {"id": 71, "attribute": 5, "name": "StartInstances", "description": "action=StartInstances"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":71,"apf_value":27}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":71,"apf_value":82}' \
    http://localhost:8002/value_mapping/

 # {"id": 72, "attribute": 5, "name": "StopInstances", "description": "action=StopInstances"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":72,"apf_value":28}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":72,"apf_value":82}' \
    http://localhost:8002/value_mapping/

 # {"id": 73, "attribute": 5, "name": "RebootInstances", "description": "action=RebootInstances"},

 # {"id": 74, "attribute": 5, "name": "AttachNetworkInterface", "description": "action=AttachNetworkInterface"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":74,"apf_value":29}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":74,"apf_value":82}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":74,"apf_value":85}' \
    http://localhost:8002/value_mapping/

 # {"id": 75, "attribute": 5, "name": "DetachNetworkInterface", "description": "action=DetachNetworkInterface"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":75,"apf_value":30}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":75,"apf_value":82}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":75,"apf_value":85}' \
    http://localhost:8002/value_mapping/

 # {"id": 76, "attribute": 5, "name": "AttachVolume", "description": "action=AttachVolume"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":76,"apf_value":29}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":76,"apf_value":82}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":76,"apf_value":86}' \
    http://localhost:8002/value_mapping/

 # {"id": 77, "attribute": 5, "name": "DetachVolume", "description": "action=DetachVolume"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":77,"apf_value":30}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":77,"apf_value":82}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":77,"apf_value":86}' \
    http://localhost:8002/value_mapping/

 # {"id": 78, "attribute": 5, "name": "DescribeSnapshots", "description": "action=DescribeSnapshots"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":78,"apf_value":19}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":78,"apf_value":87}' \
    http://localhost:8002/value_mapping/

 # {"id": 79, "attribute": 5, "name": "CreateSnapshot", "description": "action=CreateSnapshot"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":79,"apf_value":18}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":79,"apf_value":87}' \
    http://localhost:8002/value_mapping/

 # {"id": 80, "attribute": 5, "name": "DeleteSnapshot", "description": "action=DeleteSnapshot"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":80,"apf_value":21}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":80,"apf_value":87}' \
    http://localhost:8002/value_mapping/

#  {"id": 17, "attribute": 6, "name": "list", "description": "action list"},
#  {"id": 18, "attribute": 6, "name": "create", "description": "action create"},
#  {"id": 19, "attribute": 6, "name": "read", "description": "action read"},
#  {"id": 20, "attribute": 6, "name": "write", "description": "action write"},
#  {"id": 21, "attribute": 6, "name": "delete", "description": "action delete"},
#  {"id": 22, "attribute": 6, "name": "update", "description": "action update"},
#  {"id": 23, "attribute": 6, "name": "append", "description": "action append"},
#  {"id": 24, "attribute": 6, "name": "replace", "description": "action replace"},
#  {"id": 25, "attribute": 6, "name": "resume", "description": "action resume"},
#  {"id": 26, "attribute": 6, "name": "suspend", "description": "action suspend"},
#  {"id": 27, "attribute": 6, "name": "start", "description": "action start"},
#  {"id": 28, "attribute": 6, "name": "stop", "description": "action stop"},
#  {"id": 29, "attribute": 6, "name": "add", "description": "action add"},
#  {"id": 30, "attribute": 6, "name": "remove", "description": "action remove"},

 # {"id": 82, "attribute": 7, "name": "virtual_machine", "description": "VM Resource"},
 # {"id": 83, "attribute": 7, "name": "virtual_network_interface", "description": "VNIF Resource"},
 # {"id": 84, "attribute": 7, "name": "virtual_hard_disk", "description": "VHD Resource"},
 # {"id": 85, "attribute": 8, "name": "virtual_network_interface", "description": "VNIF Parameter"},
 # {"id": 86, "attribute": 8, "name": "virtual_hard_disk", "description": "VHD Parameter"},
 # {"id": 87, "attribute": 7, "name": "snapshot", "description": "VM Snapshot"}
