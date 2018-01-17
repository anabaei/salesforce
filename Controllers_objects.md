### Enable development mode 
* In quick search type `user` -> `edit` -> `enable development `

### Moving from development to production 
* https://help.salesforce.com/articleView?id=000005207&type=1
* https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_deploying_ant.htm
* Tut:  https://www.youtube.com/watch?v=YW9aPrxvK3A
* [Sandbox into pro](http://salesforce.vidyard.com/watch/yuOAaYF_-vtWigiqXxndVQ) 


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
