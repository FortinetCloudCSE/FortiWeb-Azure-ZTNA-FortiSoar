---
title: "ZTNA Azure"
weight: 1
---

## Fortinet FortiGate SDWAN Networking Workshop on Azure

In this workshop you will learn how to deploy Fortinet's FortiGate NGFW on Azure in several different use cases

### About TEC Workshops

TEC Workshops provide the learner with the opportunity to put into practice newly developed skills in an easy to launch environment that can be used for customer engagements. At a minimum a TEC Workshop will include the following:

* A use case description
* An integrated lab and demo environment

  * Informational call-outs for key points to discuss or highlight to a customer
  * Questions that could be asked while giving the TEC Workshop as a demo
  * Points of value that relate the business value to the technical feature
* A reference architecture(s)

Optional components may be included for certain use cases

The TEC Workshop will not be a completely, self-contained learning experience for a single product. A TEC Workshop will cover features and often multiple products where they relate to the use case of interest.  

Deployments will be automated for those tasks that are not salient to the learning or demonstration activity in the use case. For example, for a TEC Workshop focused on Indicators of Compromise, the system may deploy a FortiGate and FortiAnalyzer with configurations for these systems. However, the leaner will have to configure the Event Handlers for IOC setup.  

## FortiWeb ZTNA TEC Workshop
Introduction:

With increase in remote workforce and devices off networks, Security for accessing applications have been a challenge. ZTNA offers security for users that are  not present on the network and are trying to access the applications and data. FortiWeb Web Application and API security firewall offers ZTNA with lot more other capabilities, protecting both North-South and east-West traffic. Fortiweb highlights include:

* OWASP Top 10 protection signature database
* Machine learning based Anomaly and Bot detection
* ZTNA 
* API Schema protection
* Machine learning based API learning

The purpose of this TEC Workshop is to familiarize the learner with FortiWeb ZTNA approach and architectural concepts specific to the Azure Cloud environment.

## TEC Workshop Objectives

* Deploy the FortiWeb and all the required components like FortiEMS using Terraform
* Configure EMS
* Configure FortiWeb to provide access from Internet to Web application with ZTNA
* Configure FortiWeb to provide access on a trusted network to access the web API

***

{{< notice warning >}}
The examples and sample code provided in this workshop are intended to be consumed as instructional content. These will help you understand how various Fortinet and Azure services can be architected to build a solution while demonstrating best practices along the way. These examples are not intended for use in production environments without full understanding of how they operate.
{{< /notice >}}