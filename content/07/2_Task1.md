## Create your own Playbook

### Playbook Editor

To start with the creation of a new Playbook, take the following Steps:

1. Goto `Automation` - `Playbooks`

![image-20230709104331292](../assets/image-20230709104331292.png)

2. Choose any Collection you want (for example `01 - Drafts` Collection), then click on `+ Add Playbook`

<img src="../assets/Screenshot 2023-07-09 at 10.44.48.png" alt="Screenshot 2023-07-09 at 10.44.48" style="zoom:50%;" />

3. Provide a new `Name` for the Playbook, keep the default values and then click on `Create`

![image-20230709104626775](../assets/image-20230709104626775.png)

4. The Playbook Editor is now open and ready to use.

Every Playbook has to start with the `Trigger Step` This could be e.g. `Manual` if you do not want to have it executed automatically or if e.g. the Playbook should get executed when a new Alert is created, choose the `On Create` Trigger.

For more information about the Trigger Step, please have a look at the [FortiSOAR Playbook Development Guide](https://docs.fortinet.com/document/fortisoar/7.4.1/playbooks-guide/784146/triggers-steps#Triggers_&_Steps)

![image-20230709104917793](../assets/image-20230709104917793.png)

After selecting a Trigger, the `Name` and `Execution Behaviour` (Scope) needs to be defined. For Example, if the Playbook is used to reaction on an Alert, The `Alerts` Module would be selected. Multiple selections are possible if the Playbooks can be also used for other Modules.

In my case, I do not require any input to run, but the playbook should only be used in the Alerts Module.

<img src="../assets/image-20230709115825816.png" alt="image-20230709115825816" style="zoom: 50%;" />

If done with the configuration of the Step, select Save at the bottom left of the Pop-up.

Now we have added our first Playbook Step - Good Job!

Before we will execute our Playbook to validate the functionality, change the `Mode` to `DEBUG`. This is important, as by default the INFO Mode only provides us if the Playbook run was successfull or not. This is to save space within the database and not filling it up with unneccessary details at runtime. While Development, we want to see which Variable and Step has which Output or Values assigned to make it easier in case of troubleshooting.

Within the Playbook Editor, click on `INFO` at the top right corner

![image-20230709110007812](../assets/image-20230709110007812.png)

Select `DEBUG` from the dropdown menu and click on `Apply`

![image-20230709110036066](../assets/image-20230709110036066.png)

To Execute a Playbook, click on the "Play"-Button the the top right of the Playbook Editor.

![Screenshot 2023-07-09 at 11.01.09](../assets/Screenshot 2023-07-09 at 11.01.09.png)

Don't forget to regularly press `Save Playbook` button to not loose your work. This is also required, before executing a Playbook.

Let's continue adding some Steps to our Playbook in the next Section.

### Playbook Steps

To add a new Step, just "drag and drop any highlighted connecot points to add a new Step".

![image-20230709113830109](../assets/image-20230709113830109.png)

At the left side, a new Pop-up appears which allows you to choose the type of the new Step.

![image-20230709113928252](../assets/image-20230709113928252.png)

Depending on what you want to do/achieve, select the Step. To specify a Variabl use the `Set Variable` Step from the Core Steps. If you want to trigger an action e.g. within FortiClient EMS or use any availabile activity from our FortiSOAR COnnectors, use the `Connector` Step from the Execute Section, and so on. Find more details about the different Steps and capabilities within the  [FortiSOAR Playbook Development Guide](https://docs.fortinet.com/document/fortisoar/7.4.1/playbooks-guide/784146/triggers-steps#Playbook_Steps_..6)

I will first set a Variable as a next step. After selecting the Step `Set Variable` I have to choose a **Name** and then specify the variable name and it's Content. As a Value, FortiSOAR allows to use Jinja2 Expressions and Filters.

To see some examples, select the `Functions` or `Input/Output` Tab after you have clicked into the `Value` field

![image-20230709114723285](../assets/image-20230709114723285.png)

![image-20230709114739015](../assets/image-20230709114739015.png)

In my case I do not have any value I want to reference to, so I will just add a String as value.

![image-20230709114841278](../assets/image-20230709114841278.png)

`Save` the step by clicking on the button at the bottom left.

Lets add another `Set Variable`Step which will access the previous added variable. For this, we need to provide a **Name** for the Step and a `Name` for the variable.

![image-20230709115034233](../assets/image-20230709115034233.png)

After clicking into the `Value` field, you will notive that the previous Variable appears on the right under the `Input/Output`Tab

![image-20230709115446301](../assets/image-20230709115446301.png)

By selecting the Custom Variable `example` the Jinja2 Expression will be automatically added as Value.

![image-20230709115532177](../assets/image-20230709115532177.png)

As an alternative, you can also write `{{ vars. example }}`

In case the next Step within a Playbook requires to use Values from a previous Step, FortiSOAR offers a very easy solution to access those. Just select the correlating Step within the Pop-up menu and follow the tree structur to select the required variable name.

<img src="../assets/image-20230711132901386.png" alt="image-20230711132901386" style="zoom:50%;" />

Click on `Save` to save our progress. Also don't forget to save your Playbook.

The Playbook should look similar like the following:

![image-20230709115942319](../assets/image-20230709115942319.png)

Let's run out created playbook. For this click on the "Play"-Button as described above. As no input is required, click on `Execute` at the bottom left.

![image-20230709120103177](../assets/image-20230709120103177.png)

The Execution Log will appear. 

![image-20230709120126657](../assets/image-20230709120126657.png)

To debug the Playbook Steps, select the `set variable` Step. This allows to have a closer look what was the `Input` &`Output` of the Step.

![image-20230709120258179](../assets/image-20230709120258179.png)

Looking at the second Step, at the Input Tab you will see the Jinja2 Statement on how we accessed the Variable

![image-20230709120351889](../assets/image-20230709120351889.png)

And the Result can be viewed within the Output Tab

![image-20230709120422485](../assets/image-20230709120422485.png)

This was a very simple Playbook but for now this is everything you need to know to solve Challenge.

In the next Section, you will find some useful Jinja2 expression examples and Links which can be very handy.

If the Playbook ist done, you can use it e.g. within the Alerts Section. For this, just select an exiting alert and choose the `Execute` Menu entry at the top. The select the corresponding Playbook you want to execute.

<img src="../assets/image-20230711122505908.png" alt="image-20230711122505908" style="zoom:50%;" />