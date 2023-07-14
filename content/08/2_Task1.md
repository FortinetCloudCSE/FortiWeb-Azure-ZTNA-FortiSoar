---
title: "Task 1 - Quarantine Client"
weight: 10
---


As a first Task in this lab, you will develop your own Playbook to quarantine Client on FortiClient EMS. Based on the Informaition you have learned in the Prvious Chapter, the Playbook has to accomplish the following tasks:

- The Information of the Client need to be extracted based on a Security Event / Alert retrived from FortiAnalyzer/FortiWeb

  - To trigger an Attack alert, make sure that a Security profile is configured within the FortiWeb Policy, in addition, feel free to use the following string and just append it to the URL to trigger an Attack Alert

  ```url
  ?q=%27%20or%20data%20@>%20%27{"a":"b"}%27%20--
  ```

- Retrieve more details based on the Alert Information about the Client

- Provide Approval Wizard before Quarantine Client with the following Information

  - FortiClient EMS ID
  - Client IP
  - Reason to Quarantine
  - OS Version
  - FortiClient Version

- Quarantine Client on FortiClient EMS

- Don't forget to think about the case, that the Approval get's rejected.

### Hint

In case you will use the `Get all Endpoints` function of the FortiClient EMS Connector, the following Values are required:

- Value for Field: `Verifiction`:
```json
{
  "saml_id": "",
  "ldap_ids": []
}
```
- Value for Field: `Filter`:
```json
<Specify you filter here - have a look into the example playbook>
```