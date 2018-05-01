
## VisualForce
* Is a web framework than is hosted on force platform 
### Variables
* Regular variable called visualforce expressions are written in `{! }` and is case-insesitive and spaces are ignored
* Global variable are written like `$User` which has information about logged in users `{! $GlobalName.fieldName}` as `{! $User.FirstName }` 

```java
<p>The year today is {! YEAR(TODAY()) }</p>
<p>Tomorrow will be day number  {! DAY(TODAY() + 1) }</p>
<p>Let's find a maximum: {! MAX(1,2,3,4,5,6,5,4,3,2,1) } </p>
<p>The square root of 49 is {! SQRT(49) }</p>
<p>Is it true?  {! CONTAINS('salesforce.com', 'force.com') }</p>
```


### Conditional
```java
<p>{! IF( DAY(TODAY()) < 15, 'Before the 15th', 'The 15th or after') }</p>
```

## Static Resources
* Static resources allows you to deploy references like Stylesheet, Javascript or images in visualforce pages
* Setup-> Static Resources -> new -> upload file -> named `jquery` then inside visualforce you can access it via `{! $Resource.anyname }`
* If we needed to have more resource in one file, then upload zip file and use `URLFOR()` as below
```java
<apex:stylesheet value="{!URLFOR($Resource.name_of_zip_file,'relativeAddressToEahFile')}" />
// upload jQueryMobile.zip file
<apex:stylesheet value="{!URLFOR($Resource.jQueryMobile,'jquery.mobile-1.4.5/jquery.mobile-1.4.5.css')}" />
<apex:includeScript value="{!URLFOR($Resource.jQueryMobile,'jquery.mobile-1.4.5/jquery.mobile-1.4.5.js')}"/>

```

## React And Salesforce 
* Here is a simple visualforce page 
```java
<apex:page docType="html-5.0" sidebar="false">
  <!-- Begin Default Content REMOVE THIS -->
     <meta charset="utf-8"/>
     <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
     <meta name="viewport" content="width=device-width, initial-scale=1"/>
     <script src="//cdnjs.cloudflare.com/ajax/libs/react/0.14.0-alpha1/react.min.js"/> 
     <script src="//cdnjs.cloudflare.com/ajax/libs/react/0.14.0-alpha1/JSXTransformer.js"/>
     <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"/>

     <script type="text/jsx">
          var Rep = React.createClass({
               render: function() {
                    return(
                         <div>
                              <iframe width="400" height="300" src=""></iframe>     
                         </div>
                    );
               }
          });
          var RecipeBook = React.createClass({
               render: function() {
                    return (
                         <div>
                              <div>
                                   Hello, world! I am a RecipeBook.
                                   <h4> My first REACT </h4> 
                              </div>
                              <Rep/>
                         </div>
                    );
               }
          });
          React.render(
               <RecipeBook/>,
               document.getElementById('app-container')
          );
     </script>
<html>
  <body>
     <div id="app-container"> </div>
     <div>
          <h2>hello</h2>
     </div>
  </body>
</html>
</apex:page>
```
* [React & salesforce](https://www.salesforce.com/video/304788/)
* [React with salesforce tut](https://www.youtube.com/watch?v=1Ynd9qOxiHM)
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
* [An example](http://www.forcetree.com/2009/07/getter-and-setter-methods-what-are-they.html)

### Visulaforce and JavaScript RemotAccess
* This [link](https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/pages_js_remoting_example.htm)
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
And to access them just write 
```java
<div> the id is: {!$CurrentPage.parameters.id} </div>
<div> foo is: {!$CurrentPage.parameters.foo} </div>
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

### Merge Syntax
* In this way we show 
```java
{!Object.nameofAPI}
```



### Show value hide null
* if we want to show a string only when the value of input is not null from [this link](https://developer.salesforce.com/forums/?id=906F0000000AaNeIAK)
```java
/// this just return all inputs unconditionally 
 <apex:inputtext value="{!userinput}">
           <apex:actionsupport event="onclick" rerender="display" />
       </apex:inputtext> 
       
       <apex:outputpanel id="display">
        <apex:outputtext value="The name entered is {!userinput}" />
      </apex:outputpanel>  
 //// this version just check if it isn not null then renders it 
  <apex:inputtext value="{!userinput}">
           <apex:actionsupport event="onclick" rerender="display" />
       </apex:inputtext> 
       
       <apex:outputpanel id="display">
        <apex:outputtext value="The name entered is {!userinput}" rendered="{!userinput != null}"/>
      </apex:outputpanel>  
```
### Field Set
* First define `field set` in each object and then assign some fields to it. Then use `<apex:repeat` tag 
```java
<apex:repeat value="{!$ObjectType.Account.FieldState.New_set}" var="field" />
  <apex:outputField value="{!Account[field]}" />
</apex:repeat>
```
### Input form 
* Exactly above just change the outputfield with inputfield and wrap it `<apex:form>` 
```java
<apex:form>
<apex:repeat value="{!$ObjectType.Account.FieldState.New_set}" var="field" />
  <apex:inputField value="{!Account[field]}" />
</apex:repeat>
</apex:form>
```
### Input from visualforce to controller 
* This is a good example [link](https://developer.salesforce.com/forums/?id=9060G000000XiNZQA0)

### Date 
* To pass date from visualforce to controller we have input like
```java
<input type="date" name="selected_date" value="{!selected_date}" > </input>
```
* Inside controller then we define a set getter with that variabla and inside the action that is invoked we define as
```java
 public String selected_date { get; set; }
 .
 ..
 ...
 selected_date = Apexpages.currentPage().getParameters().get('selected_date');
```
### Selection List
* from this [link](https://developer.salesforce.com/forums/?id=906F000000096olIAA)
```java
<apex:selectList multiselect="false" size="1">
              <apex:selectoption itemLabel="President" itemValue="President"></apex:selectoption>
              <apex:selectoption itemLabel="Co-President" itemValue="Co-President"></apex:selectoption>
</apex:selectList>
```
#### Dynamic Selection
* Selection from visualforce and controller 
```java
<apex:selectList value="{!countries}" multiselect="false">
            <apex:selectOptions value="{!items}"/>
   </apex:selectList><p/>
 ```  
 * And in controller 
 ```java
  public String items;
  public String countries { get; set; }
  
   public List<SelectOption> getItems() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('US','US'));
            options.add(new SelectOption('CANADA','Canada'));
            options.add(new SelectOption('MEXICO','Mexico'));
            return options;
        }
        
 ```
 * And the selected value is saved into countries variable

## Create a VF link button
* If you want have a button link for each contact then create a visualforce page and just add standardcontroller="contact"
* Then in `setup>customize>contact>Buttons, Links, and Actions> new > content source = selectvisualforce> save ` then in `setup>customize>contat>layout>button> add what you just create`

