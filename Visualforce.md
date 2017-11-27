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
* In order to see the result, lets go to an account page and copy the id like `0011I0XXXXXXX79XXh` then as a suffix at the end of url followed by `?id=XXXXXXXXXXX`.
* Above can be customize as below
```java
  <apex:detail subject="{!Account.Id}"  relatedListHover="false" />
```
#### Page Params
* `?` is used for first parameter and `&` separates parameters
```java
https://ap1.salesforce.com/apex/mypage?id=743987234&foo=true
```
### Accessing Permission
* Giving access permissions for the subusers by editing the security settings in visualforce page as this [link](http://help.screensteps.com/m/salesforce/l/34860-setting-permissions-for-the-visualforce-page)

### Detour licence permisions 
* If page A depends on a controller that calls an Apex class B, and a user has access only to page A but not class B, the user can still execute the code in page A. Likewise, if a Visualforce page uses a custom component with an associated controller, security is only checked for the controller associated with the page, not for the controller associated with the component.

### <apex:pageBlock>
* Elements from main foundation of a page optionally includes title and buttons which are displayed at top/bottom. has four modes:
- detail - lines!
- maindetail - lines with a white background
- edit
- inlineEdit 
### <apex:pageBlockSection> 
* Breaking into down. Information display in columns and default number of columns are 2. It can include title and collapsible button
```java
<apex:pageBlock >
    <apex:pageBlockSection >  
    </apex:pageBlockSection>
 </apex:pageBlock>
```
* Blocksection is built as table
### <apex:outputField>
* It displaying Data datas, boolean nice formats
```java
<apex:pageBlock >
    <apex:pageBlockSection title="List" columns="1"> 
       <apex:outputField value="{!Account.name_c}"/>
```
### <apex:pageBlockSectionItem> 
* number of columns can be chosen
```java

```
### <apex:outputText>
* allows more than one fields as output in one column as
```java
<apex:page standardController="Account">
  <apex:pageBlock >
    <apex:pageBlockSection title="List"> 
        <apex:outputText value="{0}{1}">
          <apex:param value="{!Account.Name}"/>
          <apex:param value="{!Account.Type}"/>
```
* we can add labels to outputfields
```java
<apex:page standardController="Account">
  <apex:pageBlock >
    <apex:pageBlockSection title="List">
      <apex:outputLabel value="Code & Labe: " />  
        <apex:outputText value="{!Account.Name} ({!Account.Type})" />
```
* Add another column under blocksection as blocksectionItem
```java
<apex:pageBlockSectionItem >
        <apex:outputText value="{0,date,full}">
          <apex:param value="{!Account.createdDate}" />
        </apex:outputText>
</apex:pageBlockSectionItem>
```
#### Generate PDF
* add renderAs="pdf" to `<apex:page controller..`

#### Static Resources  

setup-> static resources -> click new and give a zip file and make it public.
now file is ready to use in our page
```java
<apex:stylesheet value="{!URLFOR($Resource.nameofit, 'css/main.css')}" />
```
We might have javascript in directory called js or images

```java
<apex:includeScript value="{!URLFOR($Resource.Site,'js/main.js')}" />
<apex:image value="{!URLFOR($Resource.TheLogo, `img/logo.jpg')}" width="32-" height="240" />
```


