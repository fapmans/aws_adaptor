#!/bin/sh

# AWS

# bundle instance / create network
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "BundleInstance", "description": "action=BundleInstance"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "CreateNetworkInterface", "description": "action=CreateNetworkInterface"}' \
    http://localhost:8002/value/

# describe instances
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "DescribeInstances", "description": "action=DescribeInstances"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "DescribeNetworkInterfaces", "description": "action=DescribeNetworkInterfaces"}' \
    http://localhost:8002/value/

# modify instance attribute
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "ModifyInstanceAttribute", "description": "action=ModifyInstanceAttribute"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "ModifyNetworkInterfaceAttribute", "description": "action=ModifyNetworkInterfaceAttribute"}' \
    http://localhost:8002/value/

# terminate instance
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "TerminateInstances", "description": "action=TerminateInstances"}' \
    http://localhost:8002/value/

# start instance
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "StartInstances", "description": "action=StartInstances"}' \
    http://localhost:8002/value/

# stop instance
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "StopInstances", "description": "action=StopInstances"}' \
    http://localhost:8002/value/

# reboot instance
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "RebootInstances", "description": "action=RebootInstances"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "AttachNetworkInterface", "description": "action=AttachNetworkInterface"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "DetachNetworkInterface", "description": "action=DetachNetworkInterface"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "AttachVolume", "description": "action=AttachVolume"}' \
    http://localhost:8002/value/

curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "DetachVolume", "description": "action=DetachVolume"}' \
    http://localhost:8002/value/

# Describe snapshot
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "DescribeSnapshots", "description": "action=DescribeSnapshots"}' \
    http://localhost:8002/value/

# Create snapshot
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "CreateSnapshot", "description": "action=CreateSnapshot"}' \
    http://localhost:8002/value/

# Delete snapshot
curl -v -X POST -H "Content-Type: application/json" \
    -d '{"attribute": 5, "name": "DeleteSnapshot", "description": "action=DeleteSnapshot"}' \
    http://localhost:8002/value/

    # AcceptVpcPeeringConnection
    # AllocateAddress
    # AllocateHosts
    # AssignPrivateIpAddresses
    # AssociateAddress
    # AssociateDhcpOptions
    # AssociateRouteTable

    # AttachClassicLinkVpc
    # AttachInternetGateway
    ## AttachNetworkInterface
    ## AttachVolume
    # AttachVpnGateway
    
    # AuthorizeSecurityGroupEgress
    # AuthorizeSecurityGroupIngress

    ## BundleInstance

    # CancelBundleTask
    # CancelConversionTask
    # CancelExportTask
    # CancelImportTask
    # CancelReservedInstancesListing
    # CancelSpotFleetRequests
    # CancelSpotInstanceRequests
    # ConfirmProductInstance
    # CopyImage
    # CopySnapshot

    # CreateCustomerGateway
    # CreateDhcpOptions
    # CreateFlowLogs
    # CreateImage
    # CreateInstanceExportTask
    # CreateInternetGateway
    # CreateKeyPair
    # CreateNatGateway
    # CreateNetworkAcl
    # CreateNetworkAclEntry
    # CreateNetworkInterface
    # CreatePlacementGroup
    # CreateReservedInstancesListing
    # CreateRoute
    # CreateRouteTable
    # CreateSecurityGroup
    ## CreateSnapshot
    # CreateSpotDatafeedSubscription
    # CreateSubnet
    # CreateTags
    # CreateVolume
    # CreateVpc
    # CreateVpcEndpoint
    # CreateVpcPeeringConnection
    # CreateVpnConnection
    # CreateVpnConnectionRoute
    # CreateVpnGateway

    # DeleteCustomerGateway
    # DeleteDhcpOptions
    # DeleteFlowLogs
    # DeleteInternetGateway
    # DeleteKeyPair
    # DeleteNatGateway
    # DeleteNetworkAcl
    # DeleteNetworkAclEntry
    # DeleteNetworkInterface
    # DeletePlacementGroup
    # DeleteRoute
    # DeleteRouteTable
    # DeleteSecurityGroup
    ## DeleteSnapshot
    # DeleteSpotDatafeedSubscription
    # DeleteSubnet
    # DeleteTags
    # DeleteVolume
    # DeleteVpc
    # DeleteVpcEndpoints
    # DeleteVpcPeeringConnection
    # DeleteVpnConnection
    # DeleteVpnConnectionRoute
    # DeleteVpnGateway

    # DeregisterImage
    # DescribeAccountAttributes
    # DescribeAddresses
    # DescribeAvailabilityZones
    # DescribeBundleTasks
    # DescribeClassicLinkInstances
    # DescribeConversionTasks
    # DescribeCustomerGateways
    # DescribeDhcpOptions
    # DescribeExportTasks
    # DescribeFlowLogs
    # DescribeHosts
    # DescribeIdFormat
    # DescribeImageAttribute
    # DescribeImages
    # DescribeImportImageTasks
    # DescribeImportSnapshotTasks
    # DescribeInstanceAttribute
    ## DescribeInstances
    # DescribeInstanceStatus
    # DescribeInternetGateways
    # DescribeKeyPairs
    # DescribeMovingAddresses
    # DescribeNatGateways
    # DescribeNetworkAcls
    # DescribeNetworkInterfaceAttribute
    # DescribeNetworkInterfaces
    # DescribePlacementGroups
    # DescribePrefixLists
    # DescribeRegions
    # DescribeReservedInstances
    # DescribeReservedInstancesListings
    # DescribeReservedInstancesModifications
    # DescribeReservedInstancesOfferings
    # DescribeRouteTables
    # DescribeScheduledInstanceAvailability
    # DescribeScheduledInstances
    # DescribeSecurityGroups
    # DescribeSnapshotAttribute
    ## DescribeSnapshots
    # DescribeSpotDatafeedSubscription
    # DescribeSpotFleetInstances
    # DescribeSpotFleetRequestHistory
    # DescribeSpotFleetRequests
    # DescribeSpotInstanceRequests
    # DescribeSpotPriceHistory
    # DescribeSubnets
    # DescribeTags
    # DescribeVolumeAttribute
    # DescribeVolumes
    # DescribeVolumeStatus
    # DescribeVpcAttribute
    # DescribeVpcClassicLink
    # DescribeVpcClassicLinkDnsSupport
    # DescribeVpcEndpoints
    # DescribeVpcEndpointServices
    # DescribeVpcPeeringConnections
    # DescribeVpcs
    # DescribeVpnConnections
    # DescribeVpnGateways

    # DetachClassicLinkVpc
    # DetachInternetGateway
    ## DetachNetworkInterface
    ## DetachVolume
    # DetachVpnGateway

    # DisableVgwRoutePropagation
    # DisableVpcClassicLink
    # DisableVpcClassicLinkDnsSupport
    # DisassociateAddress
    # DisassociateRouteTable
    # EnableVgwRoutePropagation
    # EnableVolumeIO
    # EnableVpcClassicLink
    # EnableVpcClassicLinkDnsSupport
    # GetConsoleOutput
    # GetPasswordData
    # ImportImage
    # ImportInstance
    # ImportKeyPair
    # ImportSnapshot
    # ImportVolume

    # ModifyHosts
    # ModifyIdFormat
    # ModifyImageAttribute
    ## ModifyInstanceAttribute
    # ModifyInstancePlacement
    # ModifyNetworkInterfaceAttribute
    # ModifyReservedInstances
    # ModifySnapshotAttribute
    # ModifySpotFleetRequest
    # ModifySubnetAttribute
    # ModifyVolumeAttribute
    # ModifyVpcAttribute
    # ModifyVpcEndpoint

    ## MonitorInstances

    # MoveAddressToVpc
    # PurchaseReservedInstancesOffering
    # PurchaseScheduledInstances

    ## RebootInstances

    # RegisterImage
    # RejectVpcPeeringConnection
    # ReleaseAddress
    # ReleaseHosts
    # ReplaceNetworkAclAssociation
    # ReplaceNetworkAclEntry
    # ReplaceRoute
    # ReplaceRouteTableAssociation
    # ReportInstanceStatus
    # RequestSpotFleet
    # RequestSpotInstances
    # ResetImageAttribute
    # ResetInstanceAttribute
    # ResetNetworkInterfaceAttribute
    # ResetSnapshotAttribute
    # RestoreAddressToClassic
    # RevokeSecurityGroupEgress
    # RevokeSecurityGroupIngress
    ## RunInstances
    # RunScheduledInstances
    ## StartInstances
    ## StopInstances
    ## TerminateInstances
    # UnassignPrivateIpAddresses
    # UnmonitorInstances      