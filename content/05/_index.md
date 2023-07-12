# Introduction

In this lab, we will begin by providing a brief introduction to FortiSOAR. FortiSOAR is a comprehensive Security Orchestration, Automation, and Response (SOAR) platform. It offers a centralized and integrated solution for managing security incidents, automating response actions, and streamlining security operations.

After familiarizing ourselves with FortiSOAR, we will proceed with a series of initial steps to get acquainted with the platform's interface and functionalities. This will help you gain a better understanding of how FortiSOAR operates and how it can be utilized in real-world scenarios.

Once we have covered the foundational aspects of FortiSOAR, we will move on to the core focus of this lab: developing your own playbook to respond to an incident reported by FortiClient EMS.

By combining the knowledge and skills acquired from previous labs, specifically the Zero Trust Network Access (ZTNA) lab with FortiWeb, you will create a playbook tailored to react efficiently to the incident. This will involve integrating the insights gained from the ZTNA lab, where you explored the secure access capabilities of FortiWeb.

During the playbook development process, you will leverage FortiSOAR's capabilities to automate response actions based on predefined conditions and triggers. These actions may include gathering additional information, analyzing the incident's severity, identifying affected endpoints, and implementing appropriate remediation measures.

By the end of this lab, you will have hands-on experience in utilizing FortiSOAR's features to create a customized playbook that combines the knowledge obtained from previous labs, particularly the ZTNA lab with FortiWeb. This exercise will help you understand the practical application of FortiSOAR in incident response and further enhance your proficiency in leveraging security automation tools.

# Overview

This lab is built as an extension of the previous Lab (ZTNA with FortiWeb). Additionally, FortiAnalyzer & FortiSOAR will be introduced as tools to solve the upcoming task.

There is no need to apply any additional Setup steps as the infrastructure already got deployed at the beginning of the previous Lab.

As similar Scenario is show in the following video by the Product Manager of FortiSOAR. In this Video, Malicious traffic got detected from a specific Workstation. With the help of FortiSOAR and the ML Engine, the SOC analyst get provided with various quick actions and additional information which helps to Quarentine the Client and mitigate the issue within seconds.

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/etWghPmIuCg?controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Lab Architecture Diagram

This Diagram provides a high-level overview of the deployed Systems and the corresponding internal IP addresses.

FortiSOAR is deployed as a Management Extension on FortiAnalyzer VM.

   ![Lab Diagram](../images/cselab.png)