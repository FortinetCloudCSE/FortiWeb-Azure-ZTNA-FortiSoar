## Creating ZTNA tags on FortiEMS

We need to create ZTNA tags to tag endpoints that connect to FortiClient. These tags will sync with FortiWeb and can be used in ZTNA rules. 

1. To create tags, on FortiClient EMS navigate to Zero Trust Tags >> Zero Trust Tagging rule >> Add. 

    ![emstags](../images/ztnatags-01.jpg)

2. Enter **name**: windowsclient, **tag endpoint as**: windows (_Press Enter for creating a new tag_), click **Add rule**

    ![emswin](../images/ztnatags-02.jpg)

3. In the rule, Select **Windows**, in OS type: **Windows**, add the Windows version as shown below. 

    ![emswindows](../images/ztnatags-03.jpg)

4. Repeat Same steps for Linux. 

    ![emslinux](../images/ztnatags-04.jpg)

5. Also Create another tag for windows vulnerbale device as show below. 

    ![emswinvulnerable](../images/ztnatags-05.jpg) 
