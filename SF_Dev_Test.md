* [Accounts](#Accounts)
* [MetaData](#MetaData)

* Heroku also can provide database tools to sync seamlessly with data from Salesforce.

### metaData
* looking at data in Salesforce, you might think that you're looking at a user interface sitting on top of a relational database. But what you’re actually looking at is an abstraction of the database driven by the platform’s metadata-aware architecture.
In this abstraction, objects are our database tables. The fields on those objects are columns, and records are rows in the database.

* Leads - People who you could potential do business yet, but have not qualified them. Unsure if they're going to buy from you. People you don't have a relationship with yet
* Contact - Someone you have a business relationship with, someone you know. Possibly has bought from you in the past
* Account - A business entity. Contacts work for Accounts
* Opportunities - Sales events related to an Account and one or more Contacts


### Accounts 
* SF stores information about customers using accounts and contacts
* Accoounts are companies you work with 
* Contacts are people working for companies
* A person can be an account called Person Account
* Person accounts are forever 
* Person accounts can't have contacts
* Person accounts dont have account hierarchy
* Account hierarchy lets you see what comapnies ABC is affiliated with
* Account team helps you which sales reps are working on ABC deal

#### Account Team
* For each account up to 5 people can have access with different roles and different level of access to each account and it's opportunities and cases

#### common issues
* Controllers vs extensions [answer](https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/pages_controller_def.htm)
* System Mode vs User mode
* With/without sharing and how that's enforced up an execution context: 
`without sharing is default and uses only when we have a global class.  With sharing means inherit rules and permissions from current user` 
* Best testing practices (design and annotations)
* The order of execution 
* Schema and Database classes
* Knowing when to use workflows/Process Builder/triggers/formula fields
* security is enforced across different types of object relationships
### Know the different types of orgs
> * `Production, Development and Testing environments who develop in force.com and publish on appexchange `
> * `Production has four types of licence which you can go up and down: Group, professional, enterprise and unlimited`
> * `Force.com will either run on top of Enterprise or Unlimited Edition`
> * `developer and sandbox editions not allow to convert to production` 
> * `if we dont need CRM functionality then we can sign up for force.com seperately`
> * ` developing environment use for developing and testing apps. developing can be done either in brower based ide or in force.com ide which is eclipse `
> * Developer Edition: `a partner to developer on force.com and publish on appexchange. Has 2 CRM and 3 force.com licence and 5 MB `
> * Partner Developer Edition ` have a developers team bigger than 2 and require a master environment to manage all the source cod each developer has it's owen developer edition and Free for enrolled partners. 20 crm and force.com licence `
> * Sandox: `is ideal for your production org only and not for commercially distribution or publishing on app exchange`
> * Testing: `developer edition transfer to sandbox and then test it there, sandbox is a copy of production sf`

 
* Different ways to move metadata from one org to another.
* Schema Builder

## Relationships on Objects in SF
### Master-Details Relationship
* Child record must have a parent
* Child record must not be standard object
* Cascade record level security from parent to child
* Cascade record deletion if parent deleted 
* Roll up summary field is available in parent for example how many child has this parent 
### Lookup Relationship
* Relationship is optional for childs
* No inherited security 
* Roll up summay not allows for parents and child can be standard object

### Avoid Hitting Governor limits
#### using limits systems
```java
System.debug('1. Number of Queries used in this Apex code so far: ' + Limits.getQueries());
System.debug('2. Number of rows queried in this Apex code so far: ' + Limits.getDmlRows());
System.debug('3. Number of DML statements used so far: ' +  Limits.getDmlStatements());   
System.debug('4. Amount of CPU time (in ms) used so far: ' + Limits.getCpuTime());
Or 
System.debug('Total Number of SOQL Queries allowed in this Apex code context: ' +  Limits.getLimitQueries());
Or
if (opptqueryresult.size() + Limits.getDMLRows() > Limits.getLimitDMLRows())
```
#### Use @future 
* Beside, bulkifying your helper methods we can use asynch functions. But no more than 10 future methods in single apex transaction and no more than 200 in 24 hours. Future mehtods can not take sObjects or objects as arguments. Can not use in visualforce controllers. 
#### One Trigger per object
* Single apex trigger for one object. 
#### Using collection and streaming
* If there are two queries on forexample opportuniyu make them one like `select id from opp where a in b and from account where id in c`
like [this](https://developer.salesforce.com/page/Apex_Code_Best_Practices)














