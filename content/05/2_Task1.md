# Prepare FortiAnalyzer and FortiWeb for the Lab

This Chapter includes necessary steps to setup Log shipping and Event Monitoring with FortiAnalyzer of FortiWeb. Please make sure you have completed this section before moving on!

## FortiWeb Preparations

1. Login to FortiWeb with the give credentials

![image-20230709100007610](../assets/image-20230709100007610.png)

2. On the left sided menu, goto `Log&Report` - `Log Policy` - `FortiAnalyzer Policy`

![image-20230709100136898](../assets/image-20230709100136898.png)

3. Select `Create New` at the top left to open the Configuration Wizard

![image-20230709100218505](../assets/image-20230709100218505.png)

4. Provide a meaningful name for the Policy and the click `OK` to save

![image-20230709100329362](../assets/image-20230709100329362.png)

5. After the Policy has been saved, click on `Create New` to a add a new entry to the policy
6. Enter the IP Address of Fortianalyzer into the corresponding field, then click on `OK` to add the entry

![image-20230709100501970](../assets/image-20230709100501970.png)

7. Check that the new entry was added successfully, click `OK` again to make sure that everything is saved.

![image-20230709100708834](../assets/image-20230709100708834.png)

8. On the left sided menu, goto `Log&Report` - `Log Config` - `Global Log Settings`

![image-20230709100817629](../assets/image-20230709100817629.png)

9. Enable FortiAnalyzer and select the previous configured FortiAnalyzer Policy

![image-20230709100858606](../assets/image-20230709100858606.png)

10. Click on `Apply` at the bottom of the Page to save the configuration.

11. To enable the global logging, open the built-in CLI by clicking on the `>_` Symbol the to top right

![image-20230709101052663](../assets/image-20230709101052663.png)

12. Execute the following commands

```shell
config log traffic-log
set status enable
end
```

13. Logging of FortiWeb to FortiAnalyzer is now enabled. Please proceed with the configuration of FortiAnalyzer

## FortiAnalyzer Preparations

1. Login to FortiAnalyzer with the given Credentials

![image-20230709101603138](../assets/image-20230709101603138.png)

2. Goto `Device Manager` and click on `Add Device` to add FortiWeb

![Screenshot 2023-07-09 at 10.17.32](./assets/Screenshot 2023-07-09 at 10.17.32.png)

3. Provide the follwoing Information, then click on `Next` to proceed with the configuration.

   - Name: `FortiWeb`
   - Serial Number: <Serial Number of FortiWeb> (This can be found at the Dashboard of FortiWeb)

   <img src="./assets/Screenshot 2023-07-09 at 10.19.36.png" alt="Screenshot 2023-07-09 at 10.19.36" style="zoom: 50%;" />

   ![image-20230709102101586](../assets/image-20230709102101586.png)

   4. Wait until the Device got added successfully. Then click on `Finish` to close the wizard.

   ![image-20230709102205239](../assets/image-20230709102205239.png)

   5. To finalize the FortiWeb configuration, select the entry from the Device table and click on `Edit`

   ![image-20230709102329079](../assets/image-20230709102329079.png)

   6. Update `Admin User` and `Password` with the given credentials, then click on `OK` to save.

   ![image-20230709102616262](../assets/image-20230709102616262.png)

   

   

   7. To be able to feed Security Events within FortiSOAR, Events need to get generated within the Event Monitor. For this to work, a so called Handler needs to be in Place. The Handler for FortiWeb is disabled by default and needs to be enabled. For this, goto `Incidents & Events` - `Handlers`

   ![image-20230709102903218](./assets/image-20230709102903218.png)

   8. Select the `Basic Handlers` Tab, then use the Search field at the top right to search for `FWB`

   ![image-20230709103021477](../assets/image-20230709103021477.png)

   9. Right click on the search result, click on `Enable` to activate the handler.

   ![image-20230709103116772](../assets/image-20230709103116772.png) 

   10. Check that the Status changes from `disabled` to `enabled` (green checkmark)

   ![image-20230709103200793](../assets/image-20230709103200793.png)#

   11. As soon as FortiWeb detects an attack, a new Event entry will get added. See the following Example:

   ![image-20230709103500888](../assets/image-20230709103500888.png)

   Please make sure, that a `Web Protection Profile` is used within the configured FortiWeb Policy. The default policies provided by FortiWeb are more than enough with regards to this lab.

   ![image-20230709103720408](../assets/image-20230709103720408.png)

12. Congratulations, you are done with the preparations. Please continue to the next Section of the Lab.