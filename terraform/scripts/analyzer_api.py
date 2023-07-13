#!/usr/bin/env python3

import requests, json, sys, time
from urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)

HOST = "https://" + str(sys.argv[1]) + "/jsonrpc"
HOST_CHECK = "https://" + str(sys.argv[1]) 
USER = sys.argv[2]
PASS = sys.argv[3]
i = True

def get_token(HOST, USER, PASS):
    body = {
        "method": "exec",
        "params": [
            {"url": "/sys/login/user","data": {"user": USER,"passwd": PASS}},
        ],
        "id": 1,
    }

    response = requests.post(HOST, data=json.dumps(body), verify=False)
    session_id = response.json()["session"]
    return session_id

def enable_fortisoar(HOST, session_id):
    body = {
        "method": "set",
        "params": [
            {
            "data": {
                "fortisoar": "enable",
                "status": "enable"
            },
            "url": "/cli/global/system/docker"
            }
        ],
        "session": str(session_id),
        "id": 1
        }

    response = requests.post(HOST, data=json.dumps(body), verify=False)
    return response.json()

# Main
while i == True:
    try:
        print("[+] Testing Connection to FortiAnalyzer")
        response = requests.get(HOST_CHECK, verify=False)
        if response.status_code == 200:
            print("[+] Connection Successful")
            break
        else:
            print("[+] Connection Failed")
            time.sleep(5)
    except:
        pass

print("[+] Setup Connection to FortiAnalyzer")
SESSION = get_token(HOST, USER, PASS)
print("[+] Connection Successful")
print("[+] Enabling FortiSoar")
print(enable_fortisoar(HOST, SESSION))
print("[+] Done")
