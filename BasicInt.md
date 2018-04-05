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




------------
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

## Lightning Flow
* Create program with UML. There are two automation tools: Process Builder and Cloud Flow Designer. Process builder you build processes and with Cloud Flow Design you build flows when users inputs.

* You can create Schedule as `Under Scheduled Actions> Set Schedule > Add Action > Create a Record> Task > Save`
#### Process Builder
* [here](https://trailhead.salesforce.com/modules/business_process_automation/units/process_builder)
* `Setup > Process Builder > save > Add Object (add trigger) > save >  Add Criteria > save` 
* It tells if some conditions meet like updating some fields, automatically update some others 
#### Cloud Flow Designer
* It is shortcut to create for example an account from home page from [here](https://trailhead.salesforce.com/modules/business_process_automation/units/flow). You define screen and then create records to make flow
* first enable it from `setup> Automation >Enable Lightning runtime`
* To create flow `setup>flow>new> drag screen into canvas> define names, fields with labels` Then drag `record create> name and assign variable accountid` then connect then save then active it.
* To add it to home page or make it Look Like Lightning `setup>builder>Lightning App Builde> new>Home Page>Clone Salesforce Default Page>drag flow to place`


## Static Resource
* `setup> static > new> upload and save as mm` thne inside VF page you have `<apex:stylesheet value="{!URLFOR($Resource.mm2)}" />` then you have your stylesheet in VF. for images we have `<apex:image url="{!$Resource.mmm} />` directly embed into VF page.  





















