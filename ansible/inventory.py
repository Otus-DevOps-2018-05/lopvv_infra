#!/usr/bin/python
# -*- coding: UTF-8 -*-

import sys
import googleapiclient.discovery
import warnings
import json
warnings.filterwarnings("ignore")


if __name__ == "__main__":
    if len(sys.argv) == 2:

        if (sys.argv[1] == "--list"):
            compute = googleapiclient.discovery.build('compute', 'v1')
            result = compute.instances().list(project='infra-210907', zone='europe-west1-b').execute()

            data_for_json = dict()
            data_for_json['app'] = []
            data_for_json['db'] = []

            for i in result['items']:
                if 'app' in i['name']:
                    data_for_json['app'].append(i['networkInterfaces'][0]['accessConfigs'][0]['natIP'])
                if 'db' in i['name']:
                    data_for_json['db'].append(i['networkInterfaces'][0]['accessConfigs'][0]['natIP'])

            json_data = json.dumps(data_for_json)

            print(json_data)
        elif (sys.argv[1] == "--host"):
            print ("{}")
        else:
            print ("Incorrect input. Use: inventory.py --list")
            sys.exit(1)

    else:
        print ("Incorrect input. Use: inventory.py --list")
        sys.exit(1)
