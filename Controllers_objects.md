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
* To create triggers to run it on batch use this [link](https://developer.salesforce.com/forums/?id=906F00000008n0zIAA)

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
###### http callout error
* this [link](https://salesforce.stackexchange.com/questions/3486/testing-httpcallout-with-httpcalloutmock-and-unittest-created-data)
###### Webservice callout from Scheduled Apex  
* this [link](http://amitsalesforce.blogspot.ca/2017/08/webservice-callout-from-scheduled-apex.html)

### Batch
* Loader: has to repeat methods and final method that we want to be repeated
* Scheduler: this is a class that we schedul on specific time frame 
* Controller: optional class - can be used to create a button to execute loader 
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


### Triggers
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

