## FortiSOAR Content Hub & Connectors

Content Hub is a vital component of FortiSOAR that provides a centralized repository of pre-built playbooks, scripts, and integrations. It serves as a knowledge base and resource center for security operations, allowing teams to leverage existing content and collaborate effectively.

Content Hub offers a vast collection of pre-defined playbooks created by Fortinet's experts and the broader cybersecurity community. These playbooks cover a wide range of use cases, including incident response, threat hunting, vulnerability management, and compliance. By utilizing these pre-built playbooks, security teams can accelerate their response times and ensure consistency in their incident handling processes.

In addition to playbooks, Content Hub provides access to a variety of integration connectors. These connectors allow FortiSOAR to connect and interact with different security tools, such as FortiWeb and FortiClient EMS, as well as third-party solutions. This seamless integration capability ensures that incidents and alarms from various sources can be ingested, analyzed, and responded to from a single platform.

Furthermore, Content Hub enables collaboration and knowledge sharing among security professionals. It allows users to contribute their playbooks, scripts, and integrations to the community, fostering a vibrant ecosystem of security automation. This collaborative approach encourages the exchange of best practices and empowers security teams to continually improve their incident response capabilities.

More Information can be found in the [FortiSOAR User Guide - Content Hub](http://docs.fortinet.com/document/fortisoar/7.4.1/user-guide/667127/content-hub)

### How to access the Content Hub

1. If not already done, expand the sidebar menu by clicking on the arrow the at top left

<img src="../assets/image-20230703165828637.png" alt="image-20230703165828637" style="zoom:50%;" />

2. Select `Content Hub`  to access the recived alerts and events



<img src="../assets/image-20230703171703304.png" alt="image-20230703171703304" style="zoom:50%;" />

3. A whole new view gets populated. This allows to search and filter for various Connectors, Solution Packs and Widgets to advance FortiSOAR

<img src="../assets/image-20230703172016548.png" alt="image-20230703172016548" style="zoom:50%;" />

The same information can be also found at the [FortiSOAR Content Hub Webpage](https://fortisoar.contenthub.fortinet.com/)

### Install FortiAnalyzer Connector

1. Search for FortiAnalyzer in the Searchbar

<img src="../assets/image-20230703172215245.png" alt="image-20230703172215245" style="zoom:50%;" />

2. Selec the `Fortinet FortiAnalyzer` Connector. A new overlay Window appear which provides more details and the ability to install the connector.

<img src="../assets/image-20230703173030364.png" alt="image-20230703173030364" style="zoom:50%;" />

3. To Install the selected Connector, click on `Install` at the bottom left of the Popup.

4. To start the Installation, click on `Confirm`

<img src="../assets/image-20230703173355701.png" alt="image-20230703173355701" style="zoom:50%;" />

5. Wait until the Connector Installation has been completed

<img src="../assets/image-20230703173455643.png" alt="image-20230703173455643" style="zoom:50%;" />

6. After the successfull Installation, it will automatically return back to the Connector Popup which provides now additional configuration fields

<img src="../assets/image-20230703174209489.png" alt="image-20230703174209489" style="zoom:50%;" /> 

7. Add a new configuration with the information show on the screenshot. Adjust the values to fit the information provided for the lab.

<img src="../assets/image-20230703175746414.png" alt="image-20230703175746414" style="zoom:50%;" />

8. Click on `Save` and validate that all Steps of the configuration verification, including the Health check are successfull.

<img src="../assets/image-20230703175926590.png" alt="image-20230703175926590" style="zoom:50%;" />



9. Close the Configuration Popup. 

10. The Installed Connector can be viewed in at the `Manage` Tab

<img src="../assets/image-20230703180909705.png" alt="image-20230703180909705" style="zoom:50%;" />

### Setup FortiAnalyzer Data Ingestion

Connectors in FortiSOAR can be used to tak action or to ingest Data into FortiSOAR like Assets, Events or Indicators, etc. Some Connectors, for example the FortiAnalyzer Connector allow to Ingest Data & take actions like `Run Report`, `LIST LOG FIELDS`, etc. These actions can be used within a playbook to "do something". We will have a closer Look into Playbooks and how Connectors can be used in the next Chapter.

- To view the predefined actions of a Connector, select the `Actions & Playbooks` Tab after you have selected a Connector

<img src="../assets/image-20230704123319431.png" alt="image-20230704123319431" style="zoom:50%;" />

To Configure the Data Ingestion of FortiAnalyzer, for example to feed Events generated by FortiClient EMS into FortiSOAR, take the following steps:

1. In the FortiSOAR menu sidebar, goto `Content Hub`, select the `Manage`Tab

<img src="../assets/image-20230704124704695.png" alt="image-20230704124704695" style="zoom: 25%;" />

2. In the Searchbar type `FortiAnalyzer`

<img src="../assets/image-20230704124749201.png" alt="image-20230704124749201" style="zoom: 33%;" />

3. Select the FortiAnalyzer Connector, and click on `Configure Data Ingestion` at the right side of the Window

<img src="../assets/Screenshot 2023-07-04 at 12.49.02.png" alt="Screenshot 2023-07-04 at 12.49.02" style="zoom: 33%;" />

4. A new Overlay Popup will appear. Click on `Let's start by fetching some data` to start the configuration process

<img src="../assets/image-20230704125148880.png" alt="image-20230704125148880" style="zoom: 33%;" />

5. To configure field mappings with example data, adjust the default value as shown below and continue by clicking on `FETCH DATA` at the bottom right corner

<img src="../assets/image-20230704125516762.png" alt="image-20230704125516762" style="zoom: 33%;" />

6. keep the default field mappings and continue with the configuration by clicking on the button at the bottom right corner

<img src="../assets/image-20230704133122563.png" alt="image-20230704133122563" style="zoom: 33%;" />

7. In this lab, we will manually trigger the ingestion as the Lab is using an unlicensed version of FortiSOAR. This is limited to 300 Actions per day which also includes Data ingestion. In an production environment, a Schedule would be configured to automtically ingest the data and add the alerts to FortiSOAR.

<img src="../assets/image-20230704133312839.png" alt="image-20230704133312839" style="zoom: 33%;" />

8. Finish the configuration of the Data Ingestion by clicking on the `Save Settings & Continue` at the bottom right corner.

<img src="../assets/image-20230704133628624.png" alt="image-20230704133628624" style="zoom: 33%;" />

9. Click at `OK` at the bottom right of the screen to close the PopUp.
10. Close the Connector configuration Wizard PopUp.
11. To Manually ingest the Events, goto `Automation` - `Data Ingestion` at the left side Menu

<img src="../assets/image-20230704133837765.png" alt="image-20230704133837765" style="zoom:50%;" />

12. An overview of all availibe Connectors wich allow Data Ingestion will appear.

<img src="../assets/image-20230704133915122.png" alt="image-20230704133915122" style="zoom: 33%;" />

13. By selecting the `Fortinet FortiAnalyzer` entry, an overview of the availible configurations will appear. Select `Trigger Ingestion Now` at the right to feed in availibe events and alerts.

<img src="../assets/Screenshot 2023-07-04 at 13.40.43.png" alt="Screenshot 2023-07-04 at 13.40.43" style="zoom: 33%;" />

14. A banner at the top of the page will appear which confirms that the ingestion is running. 
15. To view the results, switch to the `Incident Response` - `Alert` Section and view the events getting added to FortiSOAR.

<img src="../assets/image-20230704134318202.png" alt="image-20230704134318202" style="zoom:50%;" />

<img src="../assets/image-20230704134544254.png" alt="image-20230704134544254" style="zoom: 33%;" />



### Install FortiClient EMS Connector

1. In the `Content Hub` menu, go back to the `Discover Tab` and search for `FortiClient EMS`

<img src="../assets/image-20230703182044327.png" alt="image-20230703182044327" style="zoom: 33%;" />

2. Select the Connector and install if not already done.
3. Setup a new Configuration as shown below. Adjust the values to fit the information provided for the lab.

<img src="../assets/image-20230703182857999.png" alt="image-20230703182857999" style="zoom: 33%;" />

4. Click on `Save` and validate that all Steps of the configuration verification, including the Health check are successfull. 

<img src="../assets/image-20230703183009036.png" alt="image-20230703183009036" style="zoom:50%;" />