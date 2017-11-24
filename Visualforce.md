### Visualforce 
* Salesfoce is mvc model framework
* Between these two tags we can add other attributes
```java
<apex:page> ... </apex:page>
```
As 
```java
<apex:page> <apex:outputField value="Hello world!" /></apex:page>
```
* There are standard controller and also we can have customize controllers
* Standard controller of Account is called "Account 
* Objects are accessed by `!{Object.Field}` like `{!Account.Name}`
### Access to Controllers

```java
<apex:page standardController="Account"> 
  <apex:detail subject="{!Account.Id}" />
</apex:page>
```
#### Page Params
* `?` is used for first parameter and `&` separates parameters
```java
https://ap1.salesforce.com/apex/mypage?id=743987234&foo=true
```
* Giving access permissions for the subusers by editing the security settings in visualforce page as this [link](http://help.screensteps.com/m/salesforce/l/34860-setting-permissions-for-the-visualforce-page)


