---
title: "Task 2 - Verify N-S Traffic"
weight: 30
---


#### **Test ZTNA North-South Inspection**

1. To Test N-S Access, RDP to Windows10 Client (windows_client_pip address is in Terraform Output)

2. on Windows 10 VM, the FortiClient is already installed. Double click on FortiClient EMS, Click on Zero trust telemetry

    ![ztnatest01](../images/ztnatest-01.jpg) 

3. In Zero Trust Telemtry >> Input the IP of your Windows >> Click Connect

    ![ztnatest02](../images/ztnatest-02.jpg) 

4. Once the FCT is connected to EMS, you should see a Windows Tag assigned to FCT.

    ![ztnatest03](../images/ztnatest-03.jpg) 

5. Open a browser on Windows Cliet and type https://10.0.0.4 in the browser or the Public IP address of FortiWeb the Port1 is NAT'd. Remember Virtual Server we created is listening on Port1 of the FortiWeb with IP 10.0.0.4. 

  ![ztnatest04](../images/ztnatest-04.jpg) 
 
  ![ztnatest06](../images/ztnatest-06.jpg) 


6. You can also check to get to the API documentation by typing https://10.0.0.4/docs

  ![ztnatest05](../images/ztnatest-05.jpg)


7. Repeat the same step from your local machine. You should not be able to get to the FastAPI web page since you are not conencted to FCTEMS.

 ![ztnatest07](../images/ztnatest-07.jpg) 


