## FortiWeb Policy setup

1. Before creating ZTNA profiles and Tags, We need to create a Server policy on FortiWeb. To create a server policy set up a server pool on FortiWeb. 

    In Server Objects >> Server Pool >> Create new >> Enter as shown below >> Click OK

    ![fwebztna02](../images/fwebztna-02.jpg) 

2. Click Create New to create a new server in Server pool as below.

    ![fwebztna03](../images/fwebztna-03.jpg) 
    ![fwebztna04](../images/fwebztna-04.jpg) 

3. Now, Create a Virtual Server. Server Objects >> Virtual Server >> Create new >> click OK

    ![fwebztna05](../images/fwebztna-05.jpg) 

Now we will create a Virtual Server to listen on Port1 IP address
     
![fwebztna06](../images/fwebztna-06.jpg) 

![fwebztna07](../images/fwebztna-07.jpg) 

4. Create a certificate in Server Objects >> Certificates >> CA Group

    ![cert01](../images/cert-01.jpg) 

5. Create New CA group for FCTEMS and click OK. 

    ![cert02](../images/cert-02.jpg) 

6. Select Type CA, Select CA for FCTEMSXXXXXXX certificate as the CA, Click OK.

       ![cert03](../images/cert-03.jpg) 

       ![cert04](../images/cert-04.jpg) 

4. Create a Server policy , in Policy >> Server Policy >> Create New as shown below. 

![fwebztna08](../images/fwebztna-08.jpg) 

5. For Server pool, Virtual Server select the objects you created in Step 2 and 3. For HTTPS service select HTTPS

![fwebztna09](../images/fwebztna-09.jpg) 

6. Click **Advanced SSL settings**, For _Certification verification for HTTPS_ click create new: 

    ![cert05](../images/cert-05.jpg) 

7. In the New Certificate Verify Tab, select the CA you have created earlier in Step 6. Finally Clik OK on the server policy. 

    ![cert06](../images/cert-06.jpg) 

# ZTNA Policies on FortiWeb. 

8. Before setting up FortiWeb ZTNA rules, check if the ZTNA tags synced from FortiClient EMS to FortiWeb. On FortiWeb navigate to ZTNA >> ZTNA profile >> ZTNA tags. FortiWeb Might have to scroll to the end to see the tags created in earlier step. 

    ![fwebztna](../images/fwebztna-01.jpg) 

9. Create ZTNA rules to access the FortiWeb Web Server. 

    ![fwebztna10](../images/fwebztna-10.jpg) 

Click on **Add Condition**

10. Select Type: ZTNA Tag, from Tag list Windows, Match condition: Any, click OK.
 
 ![fwebztna11](../images/fwebztna-11.jpg) 

11. In ZTNA profile, Create ZTNA profile with name WebServerAccess, Set Default action to Alert and Deny. 
 
    ![fwebztna12](../images/fwebztna-12.jpg) 

12. For ZTNA rule >> Create new >> Add the rule you added in Step 9. 

    ![fwebztna13](../images/fwebztna-13.jpg) 

    ![fwebztna14](../images/fwebztna-14.jpg) 

13. Now go back to Server Policy >> Policy >> Edit the existing Policy. 
    Scroll down to ZTNA profile and assign the profile created in previous step and click Save. 

    ![fwebztna15](../images/fwebztna-15.jpg) 