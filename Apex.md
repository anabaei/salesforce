

<details>
	<summary> Publish </summary>
	
* How to [publish](https://developer.salesforce.com/index.php?title=Publish_Your_First_App_with_AppExchange_Checkout&oldid=49366#Partner_With_Salesforce)
* To publish your app first you need to go https://partners.salesforce.com/ and link your organization using same authentications you need to connect


* How to [publish](https://developer.salesforce.com/index.php?title=Publish_Your_First_App_with_AppExchange_Checkout&oldid=49366#Partner_With_Salesforce)  
* To publish your app first you need to go [https://partners.salesforce.com/](https://partners.salesforce.com/) and link your organization using same authentications you need to connect 
* Answer questions at [community](https://success.salesforce.com/successHome)
</details>


<details>
	<summary> Add page to App Builder </summary>

* In order to add a visualforce page to an app, you need to go 
```java
setup -> visualforce pages -> check the box (access via visualforce pages) 
```
* Then if you go 
```java
setup -> lightning app builder -> new ( everything basic)  
```
* Then in left column if you drag and drop a visualforce page, it drops the last one you edited from visualforce pages automatically

</details>
<details>
	<summary> Execution Governors Limits </summary>
	
* Query limits and if you exceeds these numbers it would fail
```java
SOQL- 100   to each given thread you can have 100 queries
DML- 150    update and insert 
Max records - 50,000
```
```java
Execution time limit 
10,000 millisecond CPU time  or 10 seconds 
```
* Batch Apex has its own set of limits which are higher that all run in background

</details>
<details>
	<summary> Bulkification, Triggers, Maps, List, Sets </summary>

* `Name` -> `Developer Console` -> `Debug` -> `Open Anonymous Window`
* Triggers
```java	
before insert, after insert
before update, after update
before delete, after delete
after undelete
```
* Bulkification: in order to avoid governors limits we use bulkification. One way is writing triggers to handle more than one record
* Maps a collection of keys and values
```java
map<key, value>
map<key, map<key, value>> //nested 
list<list<value>> // instead of doing one records adding to db, we have to add them into a list and do it one time DML the whole list
list.sort()
sets  // it is unique and you can put ids, string, object etc in it. are best to work with result of queries. Ex put all ids you get from a query and then take it to a query and say give me results that mathch with ids in this query
```
#### Triggers
* Best practice for triggers is to follow this pattern
```java
trigger AccountTrigger on Account (after delete, after insert, after undelete, after update, 
                                   before delete, before insert, before update)
{

AccountTriggerHandler handler = new AccountTriggerHandler(trigger.isExecuting, trigger.size);
//
// Before Insert - new record(s) being created
if(trigger.isInsert && trigger.isBefore) 
  {
    handler.OnBeforeInsert(trigger.new);
    //
    // After Insert - new record(s) being created
  }else if(trigger.isInsert && trigger.isAfter) {
   handler.OnAfterInsert(trigger.newMap);
   //
   // Before Update - existing record(s) being saved
  }else if(trigger.isUpdate && trigger.isBefore){
   handler.OnBeforeUpdate(trigger.oldMap, trigger.newMap);
   //
   // After Update - existing record(s) being saved
  }......
}
```
* Notice we keep only one function call after each one. 

#### SETS
* `SETS` everything in it are unique. you can `add` two sets as 
```java
set<Id> mycontactIds = new set<Id>();
set<Id> myOppIds = new set<Id>();

mycontactIds.add(myAct.Contact__c);
myOppIds.add(myAct.Opportunity__c);
```
```java
List<Contact> mylistContacts = [select id, Name, Account_Text__c from Contact where id IN :mycontactIds];
List<Opportunity> mylistOpps = [select id, Name, Account_Text__c from Opportunity where id IN :myOppIds];
```
#### LISTS
* Can be list of objects
```java
list<Contact> mylist = new list<Contact>();
mylist.add(mycon); 
```
* query returns list and if not found would be `empty`
* common use of `lists` is to collect objects in order to one `DML` statement
```java
List<Contact> mycontacts = new List<Contact>();
for(Contact mycon: [Select id, Name, from Contact where id IN :contactIds]) {
    /// modifications made to mycon
    mycontacts.add(mycon); //save them into a list
}
update mycontacts; // one DML
```
* If you put update inside loop it after completing `150` it would fail and undo all.

</details>	
<details>
	<summary> Batch </summary>

 Batch mood in background can process thousands of records of data limitations per thread and has three parts: 
* `Loader`: has methods to repeat and has a final method
* `Schedule`r: this is a class that we schedul on specific time frame 
* `Controller`: (optional) - can be used to create a button to execute loader or wait for scheuler to start scheduled calss

```java
SOQL- 200 
DML - 150 
CPU TIME 60,000 milliseconds
```
#### Loader
* `database.querylocator` always like this. It run the query and if there are one milion records in query then it call `execute` function in chunks like 100 each times. So when it is done all it calls finish function which usually is basic as defualt.
* So only we work with `execute` funciton.  
```java
Global class AccountLoader implements Database.Batchable<sObject>, Database.Stateful {
//
// query string that is set in the ExampleScheduler (and ExampleController if one is created)
//
public string query;
// Database.executeBatch() in ExampleScheduler call this start method
//
global database.querylocator start(Database.BatchableContext BC) {
     return Database.getQueryLocator(query);
  }
  // execute method is called by database.queryLocater -- the number of executions is the total number of
  // records returned from query divided by the number of records to be done in each batch
global void execute(Database.BatchableContext BC, List<sObject> scope) 
  {
  /// do your jobs here!
   list<Account> myLst = scope;
      for(Account x: myLst)
      {
          
      }
  }
  // after all batches have been executed, do any final cleanup tasks in this mehtod
 global void finish(Database.BatchableContext BC){
 }
}
```
#### Scheduler
* Remmeber: `type` of query here should be same as type of objects we `execute` at execution method ad loader
```java
Global class ExampleScheduler implements Schedulable {
 global void execute(SchedulableContext SC)
  {
  // create a loader class and instantiate it
  // define query in loader class
  ExampleBatchLoader myLoader = new ExampleBatchLoader();
  //
  // set the query string for the SOQL query
  //
  myLoader.query = 'select Id, AccountId, ContactId  from Case';
  // call Database.executeBatch() to start the batch process executing
  // myLoader - instantiation of the batch loader
  // myBatchSize - the number of records to process in each batch
  integer myBatchSize = 2;
  ID batchprocessid = Database.executeBatch(myLoader, myBatchSize);
  }
  
}
```
* BatchSize saying how many records we want to process at a time. If batchsize is 2 then it means if we get 4000 records, then the batch  would be 2000. If we set it to 1 then it would be 4000. Optimal is 100-200 and check if fails because of complexity of DML then decrease it. 

#### Controller(optional)
* Create a button to invoke scheduled class
```java

```

</details>
<details>
	<summary> Debuggin and Logging </summary>
	
* Debug satement
```java
   system.debug(loglevel, msg)
   system.debug(msg)
```
* Logging levels
```java
NONE, ERROR, WARN, INFO, DEBUG, FINE, FINER, FINEST
```
</details>
<details>
	<summary> Upload and Read CSVs </summary>
	
* Read csv form visualforce page as [link](http://www.sfdcpoint.com/salesforce/import-csv-file-using-apex-visualforce/)	
</details>

### VisualForce pages
* Lightining components only use server side controllers so you dont need to write controllers for them only visualforce pages requires controller

* [DML Database vs DML](#dml-database-vs-dml)
* [SOSL SF Object Search Language](#sosl)
* [SOQL SF Object query Language](#soql)
* [Thrailhead notes](#Thrailhead-notes)

### Enable development mode 
* In quick search type `user` -> `edit` -> `enable development `



#### Install MavensMate with Sublime 
* After installation go to `MavensMate -> project -> new -> connect to salesforce`
* Create new class `MavensMate ->  metadata -> new Class -> choose on templape `

### Moving from development to production 
* https://help.salesforce.com/articleView?id=000005207&type=1
* https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_deploying_ant.htm
* Tut:  https://www.youtube.com/watch?v=YW9aPrxvK3A
* [Sandbox into pro](http://salesforce.vidyard.com/watch/yuOAaYF_-vtWigiqXxndVQ) 
* [Call out from batch](https://developer.salesforce.com/blogs/developer-relations/2010/02/spring-10-saw-the-general-availability-of-one-of-my-favorite-new-features-of-the-platform-the-apex-schedulerwith-the-apex-s.html)

### Passing params to Controller from URL
* In controller construct you can define 
```java
name = ApexPages.currentPage().getParameters().get('name');
```
* And inside the visualforce page we can get url like
```java
{!$CurrentPage.parameters.name}
```
* which is actually pagerefernce like this:
```java
PageReference pageRef = ApexPages.currentPage();
```
### Merge Field Syntax
* You can merge fields to address parents in vf pages. like in a contact you can have `Account.Name` or in an account have ` Opportunity.Account.CreatedBy.Phone`

### Forms 
* You can download unmanaged packages and modify it( managed packages are not modifiable)
* or you can create a visualforce page using apex and controller

### HashMap
* Almost identical with java 
```java
 Map<String, Integer> m = new HashMap<String, Integer>(); // in java
 Map<String, Integer> m = new Map<String, Integer>{}; // in SF
 
 m.put('amir', 1);
 m.getKey(1);
 m..getValue('amir');
```
### Casting
* Below we have a list of objects `actual` which each object is a hash map, after assigning email then to retreive data we need to use casting as:
```java
List<object> actual = new List<object>{};
Map<String, Object> names = new Map<String, Object>{};
names.put('email', 'amircmpt@gmail.com');
actual.add(names);
Map<String, Object> d = (Map<String, Object>)actual[0]; // casting happen here!
d.get('email');
```

### Send reports 
* To send reports as an excel file just run below at ReportExportController.apex class 
```java
public class ReportExportController implements System.Schedulable {

    public String getOutput() {
        return null;
    }
    
    public void execute(SchedulableContext sc) {
        ApexPages.PageReference report = new ApexPages.PageReference('/00O1N0000075HE0UAM?csv=1');
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('report.csv');
        attachment.setBody(report.getContent());
        attachment.setContentType('text/csv');
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
        message.setSubject('Report');
        message.setPlainTextBody('The report is attached.');
        message.setToAddresses( new String[] { 'anabaei@sfu.ca', 'amircmpt@gmail.com' } );
        Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
        
    }
    
    public void doit(){
    SchedulableContext sc = null;
   // TheScheduleableClass tsc = new TheScheduleableClass();
    execute(sc);
    }
}
```
* You may need change the settings as [well](https://developer.salesforce.com/forums/?id=906F00000008xsLIAQ)

* To create triggers to run it on batch use this [link](https://developer.salesforce.com/forums/?id=906F00000008n0zIAA)
#### Tests Case for reports
* This [link](https://salesforce.stackexchange.com/questions/57220/test-class-not-covering-the-execute-method)
#### SQL Queries not covered
* In test cases if there are some queries inside the function it can not call them because test cases should have their own data as this [link](https://salesforce.stackexchange.com/questions/159976/soql-query-is-not-working-in-test-class-coverage/159979) explains 

#### Controllers
* To access objects from an standard controller and display them as customize data we use it as 
```java
public class conVsGood {
Contact c;
public Contact getContactMethod1() {
        if(c == null) c = [SELECT Id, Name FROM Contact LIMIT 1];
    //    System.debug(c);
        return c;
    }
    }
```
* And inside the apex:page
```java
<apex:page controller="conVsGood">
    getContactMethod1(): {!contactMethod1.name}
</apex:page>
```
### Set permission to users
 Subusers usually dont access to pages created by admin. To do that 
- Go to Set permission and create a new one
- Assign the licence which your target user carry on
- After creating a set permission, go to edit 
- Click on visualforce page access and select pages you want to allow users 
- Done!

### Add customize attribute to object
- Go to Setup, Build
- Customize 
- Select the object and add

#### Create new object in Salesforce
* here is an example of creating new Account [this](https://developer.salesforce.com/forums/?id=906F000000092OYIAY)
```java
 Account newAccount = new Account (name = 'AcName',
        BillingCity ='TestCity',
        BillingCountry ='TestCountry',
        BillingStreet ='TestStreet',
        BillingPostalCode ='t3stcd3'
        );
        
        insert newAccount;
```
* Find a query from an object
```java
List<Case> lstCase = [select Accountid, Account.name, Account.site from Case where id=: Apexpages.currentPage().getParameters().get('id)];
```
##### Bootstrap
* In order to active bootstrap you need to add cdns into the page as 
```java
<apex:includeScript value="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js" />
<apex:stylesheet value="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"/>
```
* Also disable default stylesheet in apex:page
```java
<apex:page controller="Allorders" standardStylesheets="false" >
```
#### Call JS function 
```java
<apex:page controller="calljavascript_cls" >
<script>
  function func()
  {
  alert('function calling');
  }
  </script>
  <apex:outputText value="{!callfunc}" escape="false"></apex:outputText>
 
</apex:page>
-------- apex class --------------
public class calljavascript_cls
{
public string callfunc{get;set;}
public calljavascript_cls()
{
    callfunc='<script> func(); </script>';
}
}
```
### Errors
 ` Too many SOQL queries: 101 `
 * The following error appears when you exceed the Execution Governors Limit (you can run up to a total 100 SOQL queries in a single call or context). Because Apex runs in a multitenant environment, the Apex runtime engine strictly enforces limits to ensure that runaway Apex code or processes don’t monopolize shared resources
* In this case as errors imply we have to reduce the number of queris. If there is a loop and inside that we have queries then have to take out the loop from queries. To do so we get a query and save all inside a list, then convert list to a set as 
```java
private Set<Contact> cantactSet;
private Contact[] allcontacts;

      allcontacts = [select email,lastname,firstname,id from Contact];
      cantactSet = new Set<Contact>();   
      cantactSet.addAll(allcontacts);
```
Then inside the loop just need to go through the set and if condition met then break the loop and assign the value
```java
for(Contact conti: cantactSet){
                   if(conti.LastName == contactLastName && conti.FirstName == contactFirstName )
                   {   
                     idforcontact = conti.id;
                     break;   
                   }
```

###### http callout [error](https://help.salesforce.com/articleView?id=000079772&type=1)
* this [link](https://salesforce.stackexchange.com/questions/3486/testing-httpcallout-with-httpcalloutmock-and-unittest-created-data)
###### Webservice callout from Scheduled Apex  
* this [link](http://amitsalesforce.blogspot.ca/2017/08/webservice-callout-from-scheduled-apex.html)
* Callout from scheduled Apex not supported use this [link](https://salesforcespace.blogspot.ca/2016/04/webservice-callout-from-scheduled-apex.html) Queaboe works 

### Batch

* Bulkification: writing triggers to handle more than one record at a time
* To run a sample in batch just define hello world class implements `Schedulable` interface as
```java
global class todo implements Schedulable{
   // this method should be difned 
    global void execute(System.SchedulableContext ctx){
   System.debug('you');         
       }
    }
```
* Then in `Apex Code` window we can call it as 
```java
String cron = '0 45 10 * * ?';
System.schedule('test events', cron,new todo());
```
Which runs at 10:45 am everyday/everymonth regardless of the year, also it create a Scheduled Jobs in salesforce with the name of `test events`
#### Batch in steps 
* Having a schedule batch needs to implement `schedulable` interface as
```java
global class delete_all_campaign_members implements Schedulable {

     global void execute(System.SchedulableContext ctx){
      delete_all_campaign_members_batch  sched = new delete_all_campaign_members_batch();
         sched.execute(null);
     }   
}
```
* Then to write a batch we can have 
```java
public class delete_all_campaign_members_batch implements Schedulable, Database.AllowsCallouts, Database.Batchable<sObject> {
    public void execute(SchedulableContext SC) {
      Database.executebatch(new delete_all_campaign_members_batch());
   }
   
 public Iterable<sObject> start(Database.Batchablecontext BC){
       // write the code to run here 
       
          List<contact> ls = [select id from contact];       
     return ls;    
 }
    public void execute(Database.BatchableContext BC, List<sObject> scope){      
    }
  public void finish(Database.BatchableContext info){
        
    }
}
```
* The test code would be like 
```java
@isTest
public class delete_all_campaign_membersTest {

    @isTest public static void testexecutemehtod(){
      System.Test.setMock(HttpCalloutMock.class, new hitMockEndPoint()); 
     delete_all_campaign_members abs= new delete_all_campaign_members();
     // for batch it would be identical except above line would be like below 
     // delete_all_campaign_members_batch abs= new delete_all_campaign_members_batch();
      string cron = '0 10 5 5 * ?';   
      System.Test.setMock(HttpCalloutMock.class, new hitMockEndPoint());   
      String jobId = System.schedule('myJobTestJobName', cron, abs);
      abs.execute(null);     
    }
}
```
*OR We can write codes in execute method, then it would run in size of scope below we have example of emails Schedule a little different and would be like
```java
global class sendReportsbyEmail implements Schedulable{
    global void execute(SchedulableContext sc) 
    {        
        AssignEmailsAndReports instance1 = new AssignEmailsAndReports();
        instance1.query = 'select Id from Account limit 1';
		integer myBatchSize = 1;
		ID batchprocessid = Database.executeBatch(instance1, myBatchSize);
    }    
}
```
* Actual batch class would be like 
```java
global class AssignEmailsAndReports implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
 public string query;
 global Database.QueryLocator start(Database.BatchableContext BC){
     String query = 'SELECT Id from campaign limit 1';
    /// by changing the limit you would have repeatation 
        return Database.getQueryLocator(query);
   }
  global void execute(Database.BatchableContext BC, List<sObject> scope) {
        System.debug('size= '+scope.size());
        ApexPages.PageReference report = new ApexPages.PageReference('/00O1I000006T6LG?csv=1');
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('report.csv');
       try {attachment.setBody(report.getContent());
          Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage(); attachment.setContentType('text/csv'); message.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );message.setSubject('Report'); message.setPlainTextBody('Report info from Production SF');message.setToAddresses( new String[] {'anabaei@sfu.ca', 'dleeg@sfu.ca'  } ); Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
        } catch(exception e){}
  }
  global void finish(Database.BatchableContext BC){
  }
}
```
* The test cases would be assigning the execute method as
```java
@isTest
public class AssignEmailsAndReportsTest {
    @isTest public static void test1(){
        AssignEmailsAndReports instance1 = new AssignEmailsAndReports();
        List<Campaign> actual = [SELECT Name,id,eventbriteid__c,repeatedmems__c FROM Campaign];
        instance1.execute(null, actual);
    }
    // the second test is for covering the first part which is START
    @isTest public static void test2(){
           AssignEmailsAndReports instncevar = new AssignEmailsAndReports();
           ID batchprocessid = Database.executeBatch(instncevar);
    }
    
}
```
* But schedulel test is identical with last test we had for deleting campaign members 
### Triggers
* Triggers allows us to write custom action before or after events to record in SF like validation methods. Triggers can be defined for standard objects like Accounts and contacts and some standard child objects. SF automatically fires active triggers 
```java
trigger TriggerName on ObjectName (trigger_events) {
   code_block
}
```
```java
trigger HelloWorldTrigger on Account (before insert) {
	System.debug('Hello World!');
}
```
* Also we can use `context variable` to do DML on all the records that were inserted. `Trigger.old` does the same just for old SObject 
```java
trigger HelloWorldTrigger on Account (before insert) {
    for(Account a : Trigger.New) {
        a.Description = 'New description';
    }   
}
```
* Then if we create any account then it would have a description like above.
* Each object can be a trigger, so in salseforce by going to `setup -> customize -> lead(any other object) -> triggers -> new` then we have it inside canvas
```java
trigger HelloWorld on Lead (before update) {
for (Lead l: Trigger.new) {
  l.FirstName = 'amir';
  l.LastName = 'naba';
  }
}
```
* To test this trigger works we need simply `updatng` a lead. So once we save the lead firstname and lastname affected as above
* First line of trigger inlcudes the name, what object it is running and the event fires this trigger

### Test Classes
* Writing above trigger in test class as 
* in `mavensmads -> metadata -> new class -> choose the unit test template ` and create the name as `HelloWorldTest` like <trigger name> + "Test" and it produces as 
 
```java
@isTest
private class HelloWorldTest {
	@isTest static void test_method_one() {
		// Implement test code
	}
	@isTest static void test_method_two() {
		// Implement test code
	}	
}
```
* When these annotations `@isTest` tells Apex we run a test. 
* Click on `MavensMate -> Unit Testing -> Open Apex Test Runner UI -> Select class to run `
* Test as an [example](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_example.htm)

### Test Call out End point 
Here is a simple of hiting end point 
* First write a mock response end point as 
```java
public class hitMockEndoint implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest req) {
            String fullJson = 'your Json Response';
            HTTPResponse res = new HTTPResponse();
            res.setHeader('Content-Type', 'text/json');
            res.setBody(fullJson);
            res.setStatusCode(200);
            return res;
        }
}
```
* Then when our class and mehtod for test are `Hitendpnt.Info` we write actual test as 
```java
@isTest
public class HitendpntTest { 
    @isTest public Static void testhitentpoint(){
        System.Test.setMock(HttpCalloutMock.class, new hitMockEndoint()); 
        Hitendpnt.getInfo();
    }
}
```
* Then it passes the test! 

* Notice if you want to resemble the results so assign fullJson agt hitMockEndoint as your json replies something like
```java
.
.
 String fullJson = '{"created": "2017-03-31T16:44:10Z",' + 
            '"changed": "2017-05-11T00:35:20Z", ' + 
            '"capacity": 20, ' + 
            '"capacity_is_custom": false, ' + 
            '"status": "completed", ' + 
            '"currency": "USD", ' + 
            '"listed": false, ' + 
            '"shareable": true, ' + 
            '"invite_only": false}' ;
HTTPResponse res ....
.
```
### Test JSON
* To resemble json reply we can assign a string and then convert it to any type of objects by `deserialize` command. as:
```java
String jason = '{ "bob": "bobby" }';      
Map<String, String> b = (Map<String,String>) JSON.deserialize(jason, Map<String,String>.class);
```
* If there is type of `object` since apex doesnt recognize it so we shoud use as 
```java
String j = '{ "bob": "bobby" }';  
Map<String, Object> c = (Map<String,Object>) JSON.deserializeUntyped(j);
```
* list of objects as 
```java
String item = '[{ '+
'    "pagination": { '+
'        "object_count": 37,'+
'        "page_number": 1,'+
'        "has_more_items": false '+
'    }, ' +
'    "pagination": { '+
'        "object_count": 37,'+
'        "page_number": 1,'+
'        "has_more_items": false '+
             '    }]';
List<Object> listofobjects = (List<Object>) JSON.deserializeUntyped(item);
             for(Object mems: listofobjects)
            {
                Map<String, object>  s = (Map<String, object>)mems;
                System.debug(s.get('pagination'));   
            }	     
```


### Bulkify Best Practice 
* To avoid having DML inside a loop use bulkigy technique which best practice provided [here](https://developer.salesforce.com/page/Apex_Code_Best_Practices). Query limits, which are `100` SOQL queries for synchronous Apex or `200 `for asynchronous Apex.The DML statement limit is `150` calls. To avoid DML limits we assign all result inside a list and then one DML like [this](https://trailhead.salesforce.com/modules/apex_triggers/units/apex_triggers_bulk)
#### Bulk Trigger Design Patterns
* It is suggest use Bulks in triggers to have better performance, less server resources, and are less likely to exceed platform limits or governor limits
#### Avoid hitting query limits
* Below code exceeds query limits since there is DML inside for loop as an Inefficient SOQL query 
```java
trigger SoqlTriggerNotBulk on Account(after update) {   
    for(Account a : Trigger.New) {
        Opportunity[] opps = [SELECT Id,Name,CloseDate FROM Opportunity WHERE AccountId=:a.Id];
    }
}
```
* Perform SOQL query once get the accounts and their related opportunities.
```java
trigger SoqlTriggerBulk on Account(after update) {  
    List<Account> acctsWithOpps = 
        [SELECT Id,(SELECT Id,Name,CloseDate FROM Opportunities) 
         FROM Account WHERE Id IN :Trigger.New];  
    for(Account a : acctsWithOpps) {  // Iterate over the returned accounts  
        Opportunity[] relatedOpps = a.Opportunities;  
        // Do some other processing
    }
}
```
* Also we can reduce above example like below. Get the related opportunities for the accounts in this trigger and iterate over those records.
```java
trigger SoqlTriggerBulk on Account(after update) { 
    for(Opportunity opp : [SELECT Id,Name,CloseDate FROM Opportunity 
        WHERE AccountId IN :Trigger.New]) { 
        // Do some other processing
    }
}
```
*

### Asych with Apex queable and test
* this [link](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_queueing_jobs.htm)

### Dml-database-vs-dml
* In DML if there is an error the whole transaction will fail but with database dml we can assign to skip the ones that are fail and proceess further.
```java
List<contact> ins // assign them 
insert ins // return fail if only one not procees, not partial insertion allows 
Database.insert(ins, false) // it process with partial insertion  
```
#### update 
* The signature is like
```java
public static Database.SaveResult update(sObject record to Update, Boolean allOrNone);
```
* If value of allOrNoe is false, then if one record fails remainder of operations still succeed and the result can find which one was updated.  

### sosl
* It has ability to search a particulare string across the multiple object and it is a programming way of performing a text base search.
To construct text-based search queries. Places we use SOSL: SOAP or REST calls, Apex statements, Visualforce controllers and getter methods and Schema Explorer.
* First example of SOL finds all campaign names which has ab in their NAME and return list of their name,id's
```java
 list<list<SObject>> cus = [FIND '*ab*' IN NAME Fields RETURNING Campaign(Name,id)];
// or we can have IN ALL then it would search inside all fields and not just NAME
```

#### soql
* We use it to fetch the object records from one object at a time and it is the equivalent of a SELECT SQL statement searching databases

##### passing params into. schedulable [class](https://salesforce.stackexchange.com/questions/14634/passing-parameter-into-schedulable-class)

### Thrailhead-notes
* [Thrailhead-notes](https://trailhead.salesforce.com/trails/force_com_dev_beginner/modules/apex_database/units/apex_database_intro)
* Generally, it’s easier to create a list rather than an array because lists don’t require you to determine ahead of time how many elements you need to allocate, below we create a list
```java
List<String> colors = new List<String>();
colors.add('test');
```
* We can cast general sObjects 
* DML `merge` operation can merge up to three scobjects into one and delete the rest
* DML `upsert` can be in a fiels as well like 
```
upsert sObjectList Account.Fields.MyExternalId;
```
* Apex contains the built-in Database class, which provides methods that perform
* if set to false if error occurs the successful record will be commited and no exception thrown
```java
Database.insert(recordList, false);
// best practice is 
Database.SaveResult[] srList = Database.insert(conList, false); // if it was delete, then we had Database.DeleteResult[] srList
for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()) {
    .....
    }
```
* As from [here](https://trailhead.salesforce.com/trails/force_com_dev_beginner/modules/apex_database/units/apex_database_dml)
* To change the date we have `System.Today().addYears(-4)` or `System.Today().addDays(+2)` when type is `Date`
* To active triggers after writing them `setup>apex triggers> edit> active`
* To Test Triggers in init test put the DML between two main function `Test.StartTest()` and `Test.StopTest()` as [here](https://trailhead.salesforce.com/trails/force_com_dev_beginner/modules/apex_testing/units/apex_testing_triggers)
* Difference between triggers old and new: `Trigger.new` : Returns a list of the new versions of the sObject records. Note that this sObject list is only available in insert and update triggers, and the records can only be modified in before triggers.
 `Trigger.old` : Returns a list of the old versions of the sObject records. Note that this sObject list is only available in update and delete triggers
 
 

