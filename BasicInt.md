
* [Scheduling](#scheduling)
* [Custom fields not showing in Report](https://success.salesforce.com/apex/answers?id=90630000000D4YnAAK)

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





