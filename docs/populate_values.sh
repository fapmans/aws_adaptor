#!/bin/sh

# 	{"id":1,"tenant":1,"apf":null,"ontology":false,"enumerated":true,"name":"role","description":"UFPE AWS role"}
# 	{"id":2,"tenant":null,"apf":1,"ontology":true,"enumerated":true,"name":"user.role","description":"Ontology users role attribute"}
# 	{"id":3,"tenant":null,"apf":null,"ontology":false,"enumerated":true,"name":"service","description":"AWS service"}
# 	{"id":4,"tenant":null,"apf":null,"ontology":true,"enumerated":true,"name":"resource.service","description":"Service in which the Resource is contained"}
# 	{"id":5,"tenant":null,"apf":null,"ontology":false,"enumerated":true,"name":"action","description":"Action in AWS Service"}
# 	{"id":6,"tenant":null,"apf":null,"ontology":true,"enumerated":true,"name":"action.type","description":"Type of an Action"}
# 	{"id":7,"tenant":null,"apf":null,"ontology":true,"enumerated":true,"name":"resource.type","description":"Type of a resource"}
# 	{"id":8,"tenant":null,"apf":null,"ontology":true,"enumerated":true,"name":"action.parameter","description":"Parameter of an action"}.
#   {"id":9,"tenant":null,"apf":null,"ontology":false,"enumerated":false,"name":"principal_user_id","description":"Identifier of the user"}
#   {"id":10,"tenant":null,"apf":null,"ontology":true,"enumerated":false,"name":"user.id","description":"Identifier for users in the ontology"}
#   {"id":11,"tenant":2,"apf":null,"ontology":false,"enumerated":true,"name":"role","description":"Roles at UKC"}

# Values

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute":1,"name":"admin","description":"UFPE AWS Admin role"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":2,"name":"administrator","description":"BRGB administrator role"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":1,"name":"professor_adjunto","description":"Professor Adjunto da UFPE"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":2,"name":"Professor","description":"BRGB Professor role"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":1,"name":"professor_assistente","description":"Professor Assistente da UFPE"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":2,"name":"lecturer","description":"BRGB Lecturer role"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":1,"name":"funcionario","description":"Funcionario da UFPE"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":2,"name":"staff","description":"BRGB Staff role"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":1,"name":"estudante_graduacao","description":"Estudante da Graduacao UFPE"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":2,"name":"undergrad","description":"BRGB undergraduate student role"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":1,"name":"estudante_mestrado","description":"Estudante de Mestrado da UFPE"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":2,"name":"msc","description":"BRGB MSc student role"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":1,"name":"estudante_doutorado","description":"Estudante de Doutorado da UFPE"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":2,"name":"phd","description":"BRGB PhD student role"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":3,"name":"iam","description":"IAM - AWS Identity Service"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":4,"name":"security_service","description":"Ontology Security Service"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"list","description":"action list"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"create","description":"action create"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"read","description":"action read"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"write","description":"action write"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"delete","description":"action delete"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"update","description":"action update"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"append","description":"action append"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"replace","description":"action replace"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"resume","description":"action resume"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"suspend","description":"action suspend"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"start","description":"action start"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"stop","description":"action stop"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"add","description":"action add"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":6,"name":"remove","description":"action remove"}' \
    http://localhost:8002/value/

	# -d '{"attribute":5,"name":"get_service","description":"action=get; resource=service"}' \
	# -d '{"attribute":5,"name":"list_services","description":"action=list; resource=service"}' \
	# -d '{"attribute":5,"name":"create_service","description":"action=create; resource=service"}' \
	# -d '{"attribute":5,"name":"update_service","description":"action=update; resource=service"}' \
	# -d '{"attribute":5,"name":"delete_service","description":"action=delete; resource=service"}' \

curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"GetUser","description":"action=get; resource=user"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"ListUsers","description":"action=list; resource=user"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"CreateUser","description":"action=create; resource=user"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"UpdateUser","description":"action=update; resource=user"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"DeleteUser","description":"action=delete; resource=user"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"ChangePassword","description":"action=update; resource=user; param=password"}' \
    http://localhost:8002/value/

    # -d '{"attribute":5,"name":"ListGroupsForUser","description":"action=read; resource=user; param=group_list"}' \

curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"GetGroup","description":"action=get; resource=group"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"ListGroups","description":"action=list; resource=group"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"CreateGroup","description":"action=create; resource=group"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"UpdateGroup","description":"action=update; resource=group"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"DeleteGroup","description":"action=delete; resource=group"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"RemoveUserFromGroup","description":"action=remove; resource=group; param=user"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"AddUserToGroup","description":"action=add; resource=group; param=user"}' \
    http://localhost:8002/value/

    # -d '{"attribute":5,"name":"list_users_in_group","description":"action=read; resource=group; param=user_list"}' \
    # -d '{"attribute":5,"name":"check_user_in_group","description":"action=read; resource=group; param=user"}' \
	
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute":5,"name":"GetRole","description":"action=get; resource=role"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"ListRoles","description":"action=list; resource=role"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"CreateRole","description":"action=create; resource=role"}' \
    http://localhost:8002/value/
	# -d '{"attribute":5,"name":"update_role","description":"action=update; resource=role"}' \
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":5,"name":"DeleteRole","description":"action=delete; resource=role"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":7,"name":"service","description":"IaaS Service"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":7,"name":"user","description":"User"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":7,"name":"user_group","description":"Group of users"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":7,"name":"user_role","description":"Role"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":8,"name":"user.password","description":"Users password attribute"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":8,"name":"user_list","description":"List of users in a group"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":8,"name":"user","description":"user in a group"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":11,"name":"root","description":"Root Role at Kent"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":11,"name":"professor","description":"Professor Role at Kent"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":11,"name":"staff","description":"Staff Role at Kent"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":11,"name":"phd","description":"PhD Student at Kent"}' \
    http://localhost:8002/value/
curl -v -X POST -H "Content-Type: application/json" \
	-d '{"attribute":11,"name":"student","description":"Student at Kent"}' \

# AWS IAM Actions

    # AddClientIDToOpenIDConnectProvider
    # AddRoleToInstanceProfile
    # AddUserToGroup
    # AttachGroupPolicy
    # AttachRolePolicy
    # AttachUserPolicy
    # ChangePassword
    # CreateAccessKey
    # CreateAccountAlias
    # CreateGroup
    # CreateInstanceProfile
    # CreateLoginProfile
    # CreateOpenIDConnectProvider
    # CreatePolicy
    # CreatePolicyVersion
    # CreateRole
    # CreateSAMLProvider
    # CreateUser
    # CreateVirtualMFADevice
    # DeactivateMFADevice
    # DeleteAccessKey
    # DeleteAccountAlias
    # DeleteAccountPasswordPolicy
    # DeleteGroup
    # DeleteGroupPolicy
    # DeleteInstanceProfile
    # DeleteLoginProfile
    # DeleteOpenIDConnectProvider
    # DeletePolicy
    # DeletePolicyVersion
    # DeleteRole
    # DeleteRolePolicy
    # DeleteSAMLProvider
    # DeleteServerCertificate
    # DeleteSigningCertificate
    # DeleteSSHPublicKey
    # DeleteUser
    # DeleteUserPolicy
    # DeleteVirtualMFADevice
    # DetachGroupPolicy
    # DetachRolePolicy
    # DetachUserPolicy
    # EnableMFADevice
    # GenerateCredentialReport
    # GetAccessKeyLastUsed
    # GetAccountAuthorizationDetails
    # GetAccountPasswordPolicy
    # GetAccountSummary
    # GetContextKeysForCustomPolicy
    # GetContextKeysForPrincipalPolicy
    # GetCredentialReport
    # GetGroup
    # GetGroupPolicy
    # GetInstanceProfile
    # GetLoginProfile
    # GetOpenIDConnectProvider
    # GetPolicy
    # GetPolicyVersion
    # GetRole
    # GetRolePolicy
    # GetSAMLProvider
    # GetServerCertificate
    # GetSSHPublicKey
    # GetUser
    # GetUserPolicy
    # ListAccessKeys
    # ListAccountAliases
    # ListAttachedGroupPolicies
    # ListAttachedRolePolicies
    # ListAttachedUserPolicies
    # ListEntitiesForPolicy
    # ListGroupPolicies
    # ListGroups
    # ListGroupsForUser
    # ListInstanceProfiles
    # ListInstanceProfilesForRole
    # ListMFADevices
    # ListOpenIDConnectProviders
    # ListPolicies
    # ListPolicyVersions
    # ListRolePolicies
    # ListRoles
    # ListSAMLProviders
    # ListServerCertificates
    # ListSigningCertificates
    # ListSSHPublicKeys
    # ListUserPolicies
    # ListUsers
    # ListVirtualMFADevices
    # PutGroupPolicy
    # PutRolePolicy
    # PutUserPolicy
    # RemoveClientIDFromOpenIDConnectProvider
    # RemoveRoleFromInstanceProfile
    # RemoveUserFromGroup
    # ResyncMFADevice
    # SetDefaultPolicyVersion
    # SimulateCustomPolicy
    # SimulatePrincipalPolicy
    # UpdateAccessKey
    # UpdateAccountPasswordPolicy
    # UpdateAssumeRolePolicy
    # UpdateGroup
    # UpdateLoginProfile
    # UpdateOpenIDConnectProviderThumbprint
    # UpdateSAMLProvider
    # UpdateServerCertificate
    # UpdateSigningCertificate
    # UpdateSSHPublicKey
    # UpdateUser
    # UploadServerCertificate
    # UploadSigningCertificate
    # UploadSSHPublicKey