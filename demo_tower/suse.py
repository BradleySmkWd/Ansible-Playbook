#!/usr/bin/python
import xmlrpclib
import os, ssl
MANAGER_URL = "http://192.168.141.26/rpc/api"
MANAGER_LOGIN = "admin"
MANAGER_PASSWORD = "P@ssw0rd"

import sys
channelLabel = sys.argv[2]
advisory = sys.argv[1]


# create suma client instance
suma = xmlrpclib.Server(MANAGER_URL, verbose=0)
# authenticate to obtain session key
key = suma.auth.login(MANAGER_LOGIN, MANAGER_PASSWORD)

# list systems for a given advisory
print("list systems :")
print(suma.system.listSystems(key)[0]['name'])
print(suma.system.listSystems(key)[1]['name'])
print("\n")

# list all available channels in SUSE Manager
print("list all available channels in SUSE Manager:")
print(suma.channel.listAllChannels(key))
print("\n")

# list all advisories for rhel8
#print(suma.channel.software.listErrata(key, channelLabel))

# list affected systems for a given advisory
print("list affected systems for a given advisory", advisory)
print(suma.errata.listAffectedSystems(key, advisory))
# sample output: 
# [{'name': 'rhel1.suse.lab', 'id': 1000010006, 'system_id': 1000010006, 'system_name': 'rhel1.suse.lab'}]

print("Avaiable channel: ")
print(suma.errata.applicableToChannels(key, advisory))

print("\n")
#Publish patch
print("Starting to publish patch.....")

channelLabelList = [] 
channelLabelList.append(channelLabel) 
patch_loading=suma.errata.publish(key, advisory, channelLabelList)
print(patch_loading)
# logout
suma.auth.logout(key)
