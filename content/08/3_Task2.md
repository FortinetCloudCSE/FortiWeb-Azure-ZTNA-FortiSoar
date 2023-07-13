---
title: "Task 2 - Unquarantine client"
weight: 15
---


### 2 - Unquarantine Client

As the last Task, you have developed a Playbook which allows to quarantine a Client via FortiClient EMS. As you may notice, you have lost remote access to the Client. Your next Task is to develop a Second Playbook which will unquarantine the previous Client based in the same Input Values like in Task 1.

For this, the Playbook has to accomplish the following tasks:

- Retrieve more details based on the Alert Information about the Client

- Provide Approval Wizard before Quarantine Client with the following Information

  - FortiClient EMS ID
  - Client IP
  - Reason Client got Quarantined
  - OS Version
  - FortiClient Version

- Unquarantine Client on FortiClient EMS

- Don't forget to think about the case, that the Approval get's rejected.

