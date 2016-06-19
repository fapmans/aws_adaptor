#!/bin/sh

# Value Mapping

# {"id":1,"attribute":1,"name":"admin","description":"UFPE AWS Admin role"},
# {"id":2,"attribute":2,"name":"administrator","description":"BRGB administrator role"},
# {"id":3,"attribute":1,"name":"professor_adjunto","description":"Professor Adjunto da UFPE"},
# {"id":4,"attribute":2,"name":"Professor","description":"BRGB Professor role"},
# {"id":5,"attribute":1,"name":"professor_assistente","description":"Professor Assistente da UFPE"},
# {"id":6,"attribute":2,"name":"lecturer","description":"BRGB Lecturer role"},
# {"id":7,"attribute":1,"name":"funcionario","description":"Funcionario da UFPE"},
# {"id":8,"attribute":2,"name":"staff","description":"BRGB Staff role"},
# {"id":9,"attribute":1,"name":"estudante_graduacao","description":"Estudante da Graduacao UFPE"},
# {"id":10,"attribute":2,"name":"undergrad","description":"BRGB undergraduate student role"},
# {"id":11,"attribute":1,"name":"estudante_mestrado","description":"Estudante de Mestrado da UFPE"},
# {"id":12,"attribute":2,"name":"msc","description":"BRGB MSc student role"},
# {"id":13,"attribute":1,"name":"estudante_doutorado","description":"Estudante de Doutorado da UFPE"},
# {"id":14,"attribute":2,"name":"phd","description":"BRGB PhD student role"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":1,"apf_value":2}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":3,"apf_value":4}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":5,"apf_value":6}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":7,"apf_value":8}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":9,"apf_value":10}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":11,"apf_value":12}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":13,"apf_value":14}' \
    http://localhost:8002/value_mapping/

# {"id":15,"attribute":3,"name":"iam","description":"IAM - AWS Identity Service"},
# {"id":16,"attribute":4,"name":"security_service","description":"Ontology Security Service"},
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"local_value":15,"apf_value":16}' \
    http://localhost:8002/value_mapping/

# {"id":17,"attribute":6,"name":"list","description":"action list"},
# {"id":18,"attribute":6,"name":"create","description":"action create"},
# {"id":19,"attribute":6,"name":"read","description":"action read"},
# {"id":20,"attribute":6,"name":"write","description":"action write"},
# {"id":21,"attribute":6,"name":"delete","description":"action delete"},
# {"id":22,"attribute":6,"name":"update","description":"action update"},
# {"id":23,"attribute":6,"name":"append","description":"action append"},
# {"id":24,"attribute":6,"name":"replace","description":"action replace"},
# {"id":25,"attribute":6,"name":"resume","description":"action resume"},
# {"id":26,"attribute":6,"name":"suspend","description":"action suspend"},
# {"id":27,"attribute":6,"name":"start","description":"action start"},
# {"id":28,"attribute":6,"name":"stop","description":"action stop"},
# {"id":29,"attribute":6,"name":"add","description":"action add"},
# {"id":30,"attribute":6,"name":"remove","description":"action remove"},

# {"id":31,"attribute":5,"name":"GetUser","description":"action=get; resource=user"},
# {"id":32,"attribute":5,"name":"ListUsers","description":"action=list; resource=user"},
# {"id":33,"attribute":5,"name":"CreateUser","description":"action=create; resource=user"},
# {"id":34,"attribute":5,"name":"UpdateUser","description":"action=update; resource=user"},
# {"id":35,"attribute":5,"name":"DeleteUser","description":"action=delete; resource=user"},
# {"id":36,"attribute":5,"name":"ChangePassword","description":"action=update; resource=user; param=password"},

curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":31,"apf_value":19}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":31,"apf_value":49}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":32,"apf_value":17}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":32,"apf_value":49}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":33,"apf_value":18}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":33,"apf_value":49}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":34,"apf_value":22}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":34,"apf_value":49}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":35,"apf_value":21}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":35,"apf_value":49}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":36,"apf_value":22}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":36,"apf_value":49}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":36,"apf_value":52}' \
    http://localhost:8002/value_mapping/

# {"id":37,"attribute":5,"name":"GetGroup","description":"action=get; resource=group"},
# {"id":38,"attribute":5,"name":"ListGroups","description":"action=list; resource=group"},
# {"id":39,"attribute":5,"name":"CreateGroup","description":"action=create; resource=group"},
# {"id":40,"attribute":5,"name":"UpdateGroup","description":"action=update; resource=group"},
# {"id":41,"attribute":5,"name":"DeleteGroup","description":"action=delete; resource=group"},
# {"id":42,"attribute":5,"name":"RemoveUserFromGroup","description":"action=remove; resource=group; param=user"},
# {"id":43,"attribute":5,"name":"AddUserToGroup","description":"action=add; resource=group; param=user"},
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":37,"apf_value":19}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":37,"apf_value":50}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":38,"apf_value":17}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":38,"apf_value":50}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":39,"apf_value":18}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":39,"apf_value":50}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":40,"apf_value":22}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":40,"apf_value":50}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":41,"apf_value":21}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":41,"apf_value":50}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":42,"apf_value":30}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":42,"apf_value":50}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":42,"apf_value":54}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":43,"apf_value":29}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":43,"apf_value":50}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":43,"apf_value":54}' \
    http://localhost:8002/value_mapping/

# {"id":44,"attribute":5,"name":"GetRole","description":"action=get; resource=role"},
# {"id":45,"attribute":5,"name":"ListRoles","description":"action=list; resource=role"},
# {"id":46,"attribute":5,"name":"CreateRole","description":"action=create; resource=role"},
# {"id":47,"attribute":5,"name":"DeleteRole","description":"action=delete; resource=role"},
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":44,"apf_value":19}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":44,"apf_value":51}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":45,"apf_value":17}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":45,"apf_value":51}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":46,"apf_value":18}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":46,"apf_value":51}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":47,"apf_value":21}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":47,"apf_value":51}' \
    http://localhost:8002/value_mapping/

# {"id":48,"attribute":7,"name":"service","description":"IaaS Service"},
# {"id":49,"attribute":7,"name":"user","description":"User"},
# {"id":50,"attribute":7,"name":"user_group","description":"Group of users"},
# {"id":51,"attribute":7,"name":"user_role","description":"Role"},
# {"id":52,"attribute":8,"name":"user.password","description":"Users password attribute"},
# {"id":53,"attribute":8,"name":"user_list","description":"List of users in a group"},
# {"id":54,"attribute":8,"name":"user","description":"user in a group"},

# {"id":55,"attribute":11,"name":"root","description":"Root Role at Kent"},
# {"id":56,"attribute":11,"name":"professor","description":"Professor Role at Kent"},
# {"id":57,"attribute":11,"name":"staff","description":"Staff Role at Kent"},
# {"id":58,"attribute":11,"name":"phd","description":"PhD Student at Kent"},
# {"id":59,"attribute":11,"name":"student","description":"Student at Kent"}
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":55,"apf_value":2}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":56,"apf_value":4}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":57,"apf_value":8}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":58,"apf_value":14}' \
    http://localhost:8002/value_mapping/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"local_value":59,"apf_value":12}' \