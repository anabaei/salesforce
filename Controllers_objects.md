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
