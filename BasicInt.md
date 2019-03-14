
* [Scheduling](#scheduling)
* [Custom fields not showing in Report](https://success.salesforce.com/apex/answers?id=90630000000D4YnAAK)

<details> 
 <summary> Install Environment </summary>

* Install [Java JDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html) first
* Install Eclips for java developers and go to Eclipise/help/Install Software/ and follow it [force](https://developer.salesforce.com/docs/atlas.en-us.eclipse.meta/eclipse/ide_install.htm) and then selectAll until step 4. Beauty of Eclipse is that everytime it runs then it ask where you wanna run your project then you can have different workspaces using different Eclpise on the same machine. 
* After than you need to connect your salesforce to Eclpise. 
</details>
	

<details> 
 <summary> API Connection with Nodejs </summary>
 
 * Use [jsforce](https://jsforce.github.io/document/) package 
 * How to find Tokens [link](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/quickstart_oauth.htm)
 * To get token and secret keys you should in classis view go `setup> search for apps > create > edit|new > select enable Auth2` Then you should see the API OAuth Settings as Consumer Key, consumer secret and callback url which are clientid, clientsecret and redirect url in each fetch request as 
 ```javascript
      loginUrl : 'https://login.salesforce.com/',
      clientId : 'xxxxxxxxxxxxA',
      clientSecret : '8xxxxxxxxxxxxx4',
      redirectUri : 'https://salesforceapisfu.herokuapp.com/',
      username: 'axxxxxxxxx.ca',  
      password: 'Mxxxxxx'
 ```
 * Remember: passowrd is your password like Mah..+security Token.  To get your security token go to `your name > My Settings > Personal` and reset my Security Token. Then in email you get `Oxxxxxxxxx` and append it to your login password as password!
 
 ```javascript
 const jsforce = require('jsforce');
 const conn = new jsforce.Connection({
	   loginUrl : 'https://login.salesforce.com/',
	   clientId :  config.pro.clientId,
	   clientSecret :  config.pro.cliendSecret,
	   redirectUri : 'https://salesforceapisfu.herokuapp.com/' 
  });
 ```
 Then inside each call we have 
 
 ```javascript
 
 	conn.login(config.pro.username, config.pro.password, function(err, userInfo) {
	 conn.sobject("Contact").create({
	 	FirstName: 'aaa',
	 	LastName:  'cccc', //.. req.body.LastName,
	// 	Email: 'amds@gmail.com', // req.body.email,
	// 	Title: 'ss'//, req.body.title,
	// 	//  birthday__c: req.body.birthdate,
	// 	//  Phone:  req.body.home_phone,
	// 	//  MailingStreet: req.body.mailing_address,
	// 	 //AssistantPhone: req.body.mobile
	//   }, function (err, ret) { if (err || !ret.success)
	// 	 { return console.error(err, ret); } console.log("Created contact: " + ret.name);});
	 console.log(userInfo);
	 console.log(err);
	 
   });
 ```
 
 
 </details>
 <details>
	<summary> Deactive Email notification receiving </summary>
	
* In order to deactive email receving 
```java
Setup -> Email Administration -> Deliveablility 
then select Access leve to no access 
```
 </details>	
	
 <details> 
	<summary> Read CSV files </summary>

 * To access a custom object that you created, you should first create one tab and related to that object.  
 * not bad this [link](https://salesforce.stackexchange.com/questions/123969/reading-csv-file-using-visaulforce-page) also this guy did [the same](https://github.com/kuhinoor/Test/blob/5797107baca2d01e0da5a0b5583383f60e557fb0/classes/importDataFromCSVController.cls)
 * With a basic version if our object is `eventbriteList__c` then you have at views 
 ```java
 <apex:page controller="EventbriteAttendees_controller">
<apex:includeScript value="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
<apex:includeScript value="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js" />
<apex:stylesheet value="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"/>
  <!-- Begin Default Content REMOVE THIS -->
   <div class="col-12 alert alert-warning">
     <h3> file  {!num} </h3>
     <p> {!name}  </p>
   </div>
    <apex:form >
        <apex:pagemessages />
         <div class="col-12 alert alert-warning">
        <apex:pageBlock >
            <apex:pageBlockSection columns="4"> 
                  <apex:inputFile value="{!csvFileBody}"  filename="{!csvAsString}"/>
                  <apex:commandButton value="Import EventBrite Attendees" action="{!importCSVFile}" />
            </apex:pageBlockSection>
        </apex:pageBlock>
        </div>
        <apex:pageBlock >
           <apex:pageblocktable value="{!accList}" var="acc">
              <apex:column value="{!acc.order_id__c}" />
           <!--    <apex:column value="{!acc.AccountNumber}" />
              <apex:column value="{!acc.Type}" />
              <apex:column value="{!acc.Accountsource}" />
              <apex:column value="{!acc.Industry }" />  -->
        </apex:pageblocktable>
     </apex:pageBlock>
   </apex:form>
  <!-- End Default Content REMOVE THIS -->
</apex:page>
 ```
 * Controller with name `EventbriteAttendees_controller`
 ```java
 public with sharing class EventbriteAttendees_controller {

  public List<String> chtmp { get; set; }  
  public List<String> name { get; set; }
  public Integer num { get; set; }
  public String headers { get; set; }
  public String questions { get; set; }
  public String ss { get; set; }
  public String ss2 { get; set; }
  public String ss3 { get; set; }
  public Blob csvFileBody{get;set;}
  public string csvAsString{get;set;}
  
  public String[] csvall{get;set;}
  public String[] csvFileHeaders{get;set;}
  public String[] csvFileTemp{get;set;}
  public String[] csvFileParts{get;set;}
  public String[] csvFileLines{get;set;}
  public String[] questionslist {get;set;}
  public List<EventbriteList__c> acclist{get;set;}
   
  public EventbriteAttendees_controller()
  {
    csvFileLines = new String[]{};
    acclist = New List<EventbriteList__c>(); 
  }
  public void importCSVFile()
  {
  
       try{
           csvAsString = csvFileBody.toString();
           chtmp = csvAsString.split('\n');
           num = chtmp.size();
           csvall = csvAsString.split(',');
            name = csvall;
            
           csvFileHeaders = csvAsString.split(',');
             csvFileLines = chtmp;

           for(Integer i=1;i<csvFileLines.size();i++)
           {
               EventbriteList__c accObj = new EventbriteList__c();
                  
               string[] csvRecordData = csvFileLines[i].split(',');
              
                accObj.order_id__c = csvRecordData[0] ;                                                                                   
               acclist.add(accObj);   
           }
        insert acclist;
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
        }  
  }
}
 ```
 
 </details> 
 
 <details> 
	<summary> Testing Controller </summary>	

* This [link](https://github.com/MarketoSFDC/jenkinsTest/blob/b22acd67c353ba1cccba475a07c07443c6cc2a11/classes/CustomerCommunicationControllerTest.cls) is for an example of testing controller
* How to write a test ?
#### Title
* Start with @isTest followed by `global with sharing class controllerNameTest` as
```java
@isTest global with sharing class EventbriteAttendees_controllerTest 
```
#### variables
* Define variables on top and also assign with value to the ones which were defined at constructor 
```java
 static String str = 'Order #,Order Date,First Name,Last Name,Email,Quantity';
 public static String[] csvFileLines;
 public static String[] chtmp;
```
* Then define the class instance and assign those variables to the instance in functions 
```java
EventbriteAttendees_controller eve = new EventbriteAttendees_controller(); 
EventbriteList__c accObj = new EventbriteList__c(order_id__c='11'); 
eve.accObj.order_id__c = '12';
```
* To check results 
```java
System.assertEquals(null, controller.importCSVFile());
```
#### Functions
* For each function in class define a static function starting with `static testMethod`
```java
static testMethod void testFindAll()
```
* Inside function create new instance of class and call the function, put commands between `try` and `catch` as
```java
EventbriteAttendees_controller eve = new EventbriteAttendees_controller(); 
eve.functionName(); // to cover that function in that class

// to assign an object with attributes to a class
EventbriteList__c accObj = new EventbriteList__c(order_id__c='33333'); 
eve.accObj.order_id__c = 'sss';

Map<Integer, String> m1 = new Map<Integer, String>();
m1.put(1, 'First item');
```
* And you can find more map command from [linke](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_map.htm)
* Use try catch as
```java
try {} catch (Exception e) {
    success = false;
} finally {
    System.assert(success);
 }
```

</details>
<details>
	<summary> Hit EndPoints </summary>

* At view you need to create html event as to call controller 
```java
 <apex:pageBlock >
          <apex:pageBlockSection columns="4"> 
                  <apex:commandButton value="Import" action="{!hittheserver}" />
         </apex:pageBlockSection>   
</apex:pageBlock >	 
```
* Below when you get call, hit the end point, get data and save into objects for salesforce (here as )
```java
  public void hittheserver()
    {    
         Http h = new Http();
         HttpRequest req = new HttpRequest();
         req.setMethod('GET');
         req.setEndpoint('https://www.sfu.ca/~jtoering/eventbrite/eventBriteEvents.json');
         HttpResponse res = h.send(req);
         List<Object> m = (List<Object>)JSON.deserializeUntyped(res.getBody()); // if the json is like array of objects the type also could be List<String, Object>
       
       // Here we read a list one by one and call attributes 
       for (Object item : m) 
       {
       Map<String, Object> i = (Map<String, Object>)item;
                // String  name = String.valueof(names.get('text'));
               String eventid = (String) i.get('eventId');
               String eventName = (String) i.get('eventName');
               /// sometimes the attributes own is another nested string object like below
               // Map<String, Object> names = (Map<String, Object>) i.get('eventId');
               // Each attendee data is another list we need go through
                List<Object> attendeeData = (List<Object>) i.get('attendeeData');
                for (Object attendees : attendeeData) 
                {
                    Map<String, Object> j = (Map<String, Object>)attendees;
                    Integer Order = (Integer) j.get('Order #');
                    String OrderDate = (String) j.get('Order Date');
                    String FirstName = (String) j.get('First Name');
                    String LastName = (String) j.get('Last Name');
                    Set<String> keyValues = j.keySet(); // get set of keys in a set 
	            // Create instance of salesforce object
                    EventbriteList__c accObj = new EventbriteList__c(); 
                    accObj.eventId__c = eventid;  
                    accObj.FirstName__c = FirstName;
                    accObj.LastName__c = LastName;
                    accObj.order_id__c = String.valueOf(Order); // in order to change the type of a value we use like this
                    
                    // convert a set into list of string
                    List<String> listStrings = new List<String>(keyValues);
                   
		    // read keys and values of a list(set) in below 
                      for (Integer k=11; k < listStrings.size(); k++) 
                    {
                      System.debug(listStrings[k]+ ' '+k);    // key
                      String value = String.valueOf((Object) j.get(listStrings[k])); // get the value of that key and convert it to object type 
                        // combine value and key and assignt it to Quesiton1 if index is 11!
                         if(k == 11){accObj.Question1__c = listStrings[k] + value;} 
                    }
                acclist.add(accObj);
             }
          }
         insert acclist;
    }
```
* In fact at above, we get some keys and its values like eventids or firstNames and save into the object EventbriteList__c, but also for some cases(like questions) we read the key and its value and combine togather put it as question1. 
</details>	


 <details>
	<summary> Error headers </summart>	


 * This common errors may occur 
```javascript
Error: Can't set headers after they are sent
```
 Due to having extra back slash`/` at the end of hrefs ( so leave the hrefs without `/` at the end)

 </details>

What they can do and what type of query they are able to run
### Admin
* What is Saleforce cloud? Cloud is a particular name that salesforce uses as a service, a software as a service (SAAS). It means a product that salesforce offers online without the need to mainain your own computer server or install. There are 7 salesforce cloud.
* Cloud computing has 3 different main forms. Beside SaaS, there are other types of cloud same as Heroku or Azure which provide platforn as a service PaaS and Amazon S3 for saving images which provides infrastructure as a service IaaS. Also IaaS can include monitoring, log access, security, load balancing and clustering, as well as storage resiliency, such as backup.

1. *Sales* sale could tracks customer information and interaction and permit managers(admins) to review data from team performance and make decisions.
2. *Service* service cloud is for customer service agents and empowers them with shared data, document and rapid solution base
3. *Marketing* cloud nurtur marketing to improve emails, messages, and social experience and engage noneresponders customers while advertising tracking right contacts and personalize web wontent and connecting to sales 
4. *Analytics* perform deep data analytics using time tested methods for evaluating performance
5. *Community* cloud fasts colaboration between customers and partners and partners
6. *App* provides rapid development and deployment extending CRM 
7. *IoT* is event processing engine that connects products and devices to salesforce and gain vivid pircutre of product usage

## HTTPRequest
*
```java
 Http h = new Http();
 HttpResponse res = h.send(req);
         String loc = res.getHeader('Location'); // get location of the redirect
         req = new HttpRequest();
         req.setEndpoint('https://www.eventbriteapi.com/v3/users/me/owned_events/?token=7HZG7FTKQ4UMA7BOVIVV&page='+pagen);
         req.setMethod('GET');
         req.setHeader('Content-Type', 'application/json');
         req.setHeader('Accept','application/json');
         res = h.send(req);
```
### Serialize (stringify) 
* It converts a text(json) into objects as we recevive httprequest result we have to use it to convert to objects as
```java
Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
             Map<String, Object> paginations = (Map<String, Object>) m.get('pagination');
```
* The `JSON.stringify()` method converts a JavaScript value Objects to a JSON string.

### Admin Change management from Sandbox
When you ask how many customers bought this product this year? it means have to use process builder or create classes to address it. So you have to build, test and then deploy. It is called application lifecycle management or change management
* Four stages for change sets: `Authorize Deployment`, `Create outbound change set`, `upload from sandbox`, `review inbound changes`
* Change set sends the new modifications from sandbox to your production 
* If you have several sandboxes or refreshing sandbox on regulare bases, then have to create a developer template in production then assign it to individual who wants to develop in sandbox as `new user> deactive production> active sandbox`
* Quick Deployment roll out your customizations to production faster by running tests as part of validations and skipping tests in your deployments(to save time). Validation is a tool to check the result of deployment component
* `Test levels` enable you to choose which tests are run in a validation or deployment(we use default)
* Three parts of governance to `Manage Changes`:
* 1- `Center of Excellence`: different group work togather to ensure changes support bussiness requirements and allow them be updated with changes 
* 2- `Release Management`: By using backlog list we can prioritize the tasks and share with everyone 
* 3- `Design Standards`: follow standards in developing like having description field for all objects
* Ant migration is like change set but in terminal environment and requires setting username/password on local disk
* In change set you can only move metadata between sandbox and production, they are cloud based and not ideal when usign version control
* Ant is easy to script with Ant(java) you can retrive metadata and deploy to any organazation easily by [this](https://trailhead.salesforce.com/modules/alm_deployment/units/alm_migrate) 
### Application Life Cycle
* Development LifeCycle:
* 1- Release Manager: is charge of pulling changes from version control
* 2- Product Manager: provides the business requirements of apps and features and work with development to address them.
* 3- Sofware Developer: Develops new functionality in sandbox
* 4- Quality engineer: Test new functionality 
* 5- Administrator: perform admin task in production 
* Anytime you deploy new change sets, create back up all metadata first and have a backup plan, creaet a profile to lock users and just allow acceptance users to test data
* Metadata type is a representation of configuration and customization in salesforce in XML format
### Agile
* Agile project management is an iterative approach to managing software development projects that focuses on continuous releases and incorporating customer feedback with every iteration
### Trigger
When you use `insert`, `update` and `upsert` statement, salesforce perform the following events in order: 
* Before salesforce executes events, browser runs javascript validation if record contains any picklist, if so check the valuses
* Loads the new record field values and overwrites the old values
* If the request came from standard UI edit page, sf check 
 1- Valid field formats
 2- Maximum field length
 * Run user defined validation rules 
 * Now execute all `before` Triggers
 * Save th record to database, but doesnt commit yet
 * Execute all `after` Triggers
 * Execute assignemtn rule
 * Execute workflow rules
 * If the reocrd was updated in workflow, fires before and after update triggers one more time
 * Execute process
 * Execute flows
 * Executes Criteria Based Sharing evaluation
 * Commits all DML operations to the database
##### Hello world trigger
* On any object create new trigger. 
Every trigger uses trigger loop. In fact, Trigger.new is a list of records that entering our trigger.
```java
trigger HelloWorld on Lead (before update) {
for(Lead l: Trigger.new){  //trigger loop 
   l.firstname = 'hello';
   }
}
```
Because it is before event, so there is no need to save, it would eventually saved. But if it was after event, we needed to save it explicitly 

 
### Data Type
* from [here](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_date.htm#apex_methods_system_date)
```java
Date myDate = Date.newInstance(1960, 2, 17);
Date newDate = mydate.addDays(2);
```
```java
Integer.valueOf('123');
a.toString();

```
* #### Blob, DateTime, Time, ID. Object, Integer: 32-bit , Long: 64-bit number with mn -2^63, Double: same as long just can have decimal point 
* Blob: A collection of binary data stored as a single object and is used to save crypto class objects. Whcih are used for secuting content in integration with AWS or Google.

### Accounts
*  Customers or individuals you do business with it can be Bussiness or person accounts
### Contacts
* Employee of the each company(Account) you work with
### Leads
* Leads are people and companies that you’ve identified as potential customers
### Opportunites 
* Opportunities are deals in progress
* Opportubities can have stages baed on probablity of each

### Campaign: a tool to track teams
* A tool to track teams with leads, contracts, accounts, tasks, activitis and files and track team actions
### Report : generate any data we need to review 
* A certain report that allow measurement by creating new ones we have different types of reports and share it
### Connect to Oracle 
* Install the app from [here](https://trailhead.salesforce.com/projects/quickstart-lightning-connect/steps/quickstart-lightning-connect1)

------------

* Users can track activities by runing queries with their emails, accounts tasks and dates  etc they call it campaign
* Users can use different email templates or cutomoize them 
* Users can add custom fields to common data types

#### Reports Subscribers
We have to create a user on salesforce with salesforce platform licence. To do so 
- Setup-> profiles-> clone from salesforce platform licence and on editing check reports and folders 
- Create a user using same licence then go to reports and change folder of report shares
- On reports click on the icon infront of folder of reports and on drop down menu choose share with usres.
 
## Security
* Assiging a licence determines which profiles available for each user. 
* We can't delete a user, but can `Deactive` so it can't login. It is in `Users->Edit>-Active Box`. Not allowing deactive you can `freez` a user as `User page->freeze`
* `setup->Passowrd policies`
* `Set IP address` if for whole org then they still can log in outside of range need to answer challenge questiions. If `set IP address`is for a singl profile, then all users of that profile are locked out. `Setup -> Network Access or Profiles`
* Restrict login access by profile. `Setup->profiles->Login Hours`
* User's `profile` determines the objects they can access. profiles uses for minimum limitation and permission sets for more
* `Permission Sets` grant additional permissions to user. `setup -> Permission Sets -> new -> license --None- ` 
* `Field permission`: first do `setup -> Management Settings -> enable Enhanced Profile User`. In some cases, you want users to have access to an object, but limit their access to individual fields
* Control access to record from `setup -> Sharing Settings -> `. Select `private` records makes them only visible to owners and roles above them in hierarchy. using `Grant Access Using Hierarchies checkbox` disable accing to users above owner. 
* Role Hierarchy `setup -> role`. Needed for `Public Group` a group of users to extend access beyond role hierarchy. `public group-> new ` then `sharing setting -> Sharing Rules -> new -> select from which users/objects -> select to which users/obejcts -> select what type of sharing -> save!`
* You can change accessing to object fields by checking value of each field `Setup> Security Controls> Sharing Settings> Manage sharing settings for 'any object you want'--> New` from this [link](https://developer.salesforce.com/forums/?id=906F0000000AyojIAC)


## Formulate Fields

* Create new feilds which depends on other fields based on furmulate. In lightening `setup>object manager>selectobject>Fields & Relationships>new >Formula> select type (text for ex)> then assign it`
* To convert `DateTime datatype` to `Date` need DATEVALUE() as `TODAY () - DATEVALUE(CreatedDate)`
* To have a summary field in total for example sum of all accounts we use `Roll-up` as `setup>object manager>Account>Feild & Relations>New>Roll-up>sum>Aggregate Field`

## Validatation
* Validation rules verify that data entered by users in records meet standards. You can create validation rules for objects, fields, campaign members, or case milestones. In lightening `setup>object manager> Account> Validation Rule> LEN( AccountNumber) != 8 ` or date  must be in curret year`YEAR( My_Date__c ) <> YEAR ( TODAY() )` more example from [link](https://trailhead.salesforce.com/trails/force_com_dev_beginner/modules/point_click_business_logic/units/validation_rules)

## Many to Many Relation
* `Master detail` make one to many relationship. So we have to create an associatied table among two tables and create two master details in that associated table as resource from [here](https://developer.salesforce.com/docs/atlas.en-us.fundamentals.meta/fundamentals/adg_relationships_many_relationship.htm)


## DE
* Apex is a strongly typed, object-oriented language that allows developers to execute flow and transaction-control statements on the Lightning Platform platform server, in conjunction with calls to the Lightning Platform APIs. Example of sending email [code](https://trailhead.salesforce.com/modules/developer_console/units/developer_console_source_code)
* Execute classes Anonymous as `Debug | Open Execute Anonymous Window`
* Logs are cumulative. from the least amount of data logged (level = NONE) to the most (level = FINEST) as levels increase it covers more logs [link](https://trailhead.salesforce.com/modules/developer_console/units/developer_console_logs?trailmix_creator_id=00550000006yDdKAAU&trailmix_id=platform-essentials-for-devs). `Debug > change log level>add/change`
* Customize logs view from `debug>view log panel> select> save as perspective select from debug`
* Checkpoint to see details of code. first assign level of log of `apex code ` to `finest`. Then select line you want by adding a `red .` on left side then `run program> checkpoint tab> click on the file in checkpoint table > select heap tab> click on class name> click on instances table > see details`

## SOSL vs SOQL
* If I want to find a word `crisis` and dont know which field of objects should I search I use SOSL but if I knew which field of object I am looking for I use SOQL which is the equivalent of a SELECT SQL. SOSL is like below to search throuhg all contants fields and resurn with similiar and not exaxt results because it is index search which is faster and has more cool features as this [here](https://trailhead.salesforce.com/trails/force_com_dev_beginner/modules/search_solution_basics/units/search_solution_basics_choosing)
```java
List<List<sObject>> searchList = [FIND 'Crisis' IN ALL FIELDS RETURNING Contact(FirstName, LastName), Account(name), Campaign]; // so inside searchList[0 ] there is list of results.
```
SOSL within multiple objects. You can add which fields like by adding `IN email FIELDS RETURNING`.
* To optimize SOSL define synonyme groups in `Setup> Synonyms> SelectSynonyms`


### Approvals
* Create email template `setup>template>select html> select one letterhead(if dont have create)>`
* start approval `setup> approval process> opportunity> Create New Approval Process | Use Jump Start Wizard> ` then define `Initial Submission Actions ` and `Final Approval Actions`

## Custom Metadata
* Custom metadata types let you use records to configure your app without worrying about migrating those records to other orgs. So in custom setting you should create same metadata in dev environment then to sandbox and then in production but with custom metadata we can use packages to transfer metadata, records and some functions
* Create an app to define which vacation is available for each account tier need to develop and deploy to production env. 
* Create a metadata `setup> Custom Metadata Types> new` then create custom fields and in details page `manage name` add records
* In Test you should add `@IsTest(SeeAllData=true) ` to read metadata as well
* You can use custom metadata relationship to connect with other metadatas and as connected table among two entities
* We can create objects here as well by draging from left side bar and can add fields to object by draging them into object a good [source](https://trailhead.salesforce.com/trails/force_com_dev_intermediate/modules/custom_metadata_types/units/custom_metadata_types_create_md_relationships)

## Static Resource
* `setup> static > new> upload and save as mm` thne inside VF page you have `<apex:stylesheet value="{!URLFOR($Resource.mm2)}" />` then you have your stylesheet in VF. for images we have `<apex:image url="{!$Resource.mmm} />` directly embed into VF page. 

## Schema Builder
* Schema Builder is a tool that lets you visualize and edit your data model. It shows field values, required fields, and how objects are related, by displaying lookup and master-detail relationships
* Also we can manage permission for custom fields directly `right click on field> manage permission` [link](http://www.infallibletechie.com/2013/10/schema-builder.html)

# Mobile apps
* After creating users can download them from app store
## Create Global Action
* `setup>Global Actions>new> select object> select which tabs to display> assign predefined options > save`
* Global actions let users create records, but the new record has no relationship with other records. And they’re called global actions because they can be put anywhere actions are supported—on record detail pages, but also places like the feed or Chatter groups.
## Object-specific actions
* Differences between global actions and Object-specific actions. Object-specific actions can update records and create records that are automatically associated with related information. Also to make them visible into mobile app, we dont add them into layout we just make available to users
## Compact layout 
* When opening a record in SF mobile app, you can see highlights from fields which we call them compact layout.
* Create a layout: `object managment settings for contacts> compact layout>new` 
* Assign it : System use default layouts unless we tell `object management> compact layout > click on a compact> compact layout assignment > select primary layout> save`
## Navigation Mobile
* To access visualforce pages in mobile app we need creating tabs
* To change the navigation menu `setup>Salesforce Navigation> save`
* More on mobile app dev is [here](https://trailhead.salesforce.com/trails/salesforce1_mgmt/modules/salesforce1_rollout)
* In account settings we should allow users to relate a contact to multiple accounts.

## Packaging
* To go to app then `setup>app menue`
* To create namespace to allow customers to see the packages you created  and add apps into them later `setup>packages> edit developer> continue`
* To Create app in classic: `setup > apps > Quick Start> ` 

### Integration with Force
* Event drive behaviour with outbound messaging send notification to SOAP servers based on what we define
* `Create > Workflow Rules> New role on anyobject > set criteria > Add workflow action > new outbound message > pick fields to cross`


## scheduling
* why Schedulign jobs? they are usefull for sending emails, data snapchots, expensive caculation (like running on night), Accounting. 
* Only `100` scheduled apex jobs at one time per org are allowed.
* Triggers, queueable jobs and scheduling are three different tools for 
* a resource from [here](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_scheduler.htm)
##### Cron Expression
* It is a system that identify time as below where function1 implements schedulable interface
```java
public static string cronexpression = '0 0 13 1 * ?';
System.schedule('test', cronexpression, new thefunction());
```
* It means it runs at 13 on first day of any month regardless of the year. `thefunction` is as below which has to have schedulable interface in it
```java
global class thefunction implements Schedulable{
    global void execute(SchedulableContext SC) {
      System.debug('done it');
   }
}
```
<details>
	<summary> Test class </summary>

* Annotation `@isTest` means test context. In this way, you can exclude it from your org’s code size limit of `6 MB`.	
* 	
</details>

## Batch
* High volume processing is possible on salesforce in Batch jobs.  It is capable to run even milions of records. It can be use in Billing customers, complex math calculations, mass conversion of records, mass callouts to outside APIs 
* Each batch job has three parts `sart`, `execute` and `finish`
* Only 5 batch jobs per org running simultaneously and if use Apex flex queue we can have up to 100 batch jobs to be enqueued
* By built in function we can pass any instance of executeable batch as 
```java
Database.executeBatch(new Welcome());
```
By running above it immediately create a batch job in salesforce queue and salesforce attempt to executed asap and run.  
```java
global class welcome implements Database.Batchable<sObject>
{
 String query = 'SELECT id, Name from Contact';
  
  // this indicate what the scope of our data are in relation to the batch
  global Database.QueryLocator start(Database.BatchableContext BC)
  {
    return Database.getQueryLocator(query);
  }
  // in mandatory execute part, sf passes batchable context which is some info about job and a list of sobjects. 
  global void execute(Database.BatchableContext BC, List<Contact> contacts)
  {
   System.
  }
  // small to do things here, like some kind of error handling mechanism
  global void finish(Database.BatchableContext BC)
  {
   // To do 
  }
  
}
```
* To make a batch file an schedulable file, just implement schedule interface and add execute welcome message on top as you see 
![dd](https://user-images.githubusercontent.com/7471619/39826567-fc14147a-5369-11e8-8279-b30746a81e6c.png)

	
### Testing a batch 
![1](https://user-images.githubusercontent.com/7471619/39826787-bc56fa9a-536a-11e8-9a3e-4ccae6ec44a7.png)
Assign Template 
![2](https://user-images.githubusercontent.com/7471619/39829003-e638fd0c-5371-11e8-9c69-12889cf065c8.png)


----------

* Below send an email as `sendingemailfle ins = new sendingemailfle();
   List<String> a = new List<String>();
   a.add('anabaei@sfu.ca');
   ins.sendnow('ss',a);`
```java
public class sendingemailfle {
 public void sendnow(String message, List<String> a)
   {
       List<String> contactstosend = new List<String>();
       contactstosend.add('anabaei@sfu.ca');
      // contactstosend.addAll(contactIDs);
       Messaging.SingleEmailMessage email = new  Messaging.SingleEmailMessage();
       email.setToAddresses(contactstosend);
       email.setPlainTextBody('DS');
       email.setSubject('SS'); 
       List<Messaging.Email> emailstosend = new List<Messaging.Email>();
       emailstosend.add(email);
       Messaging.sendEmail(emailstosend);
   }
}
```
* To send mass emails we have 
```java
  public void sendmassemail(List<Contact> contacts)
   {
       
       List<Contact> contactsToUpdate = new List<Contact>();
       List<Id> contactid = new List<Id>();
       for (Contact contact:contacts)
       {
           contactid.add(contact.id);
          
        //   contact.Welcome_Email__c = Datetime.now();
           contactsToUpdate.add(contact);
       }
       Messaging.MassEmailMessage massEmail = new Messaging.MassEmailMessage();
       massEmail.setTargetObjectIds(contactid);
    //   massEmail.setTemplateId(getwelcomeTemplateId());
       Boolean allorNone = true; // it tells if we should continue message delivery if encounter an error or halt. here it says we should halt if anything goes wrong
   }
```





