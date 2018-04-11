* [Accounts](#Accounts)
* [MetaData](#MetaData)

* Heroku also can provide database tools to sync seamlessly with data from Salesforce.

### metaData
* looking at data in Salesforce, you might think that you're looking at a user interface sitting on top of a relational database. But what you’re actually looking at is an abstraction of the database driven by the platform’s metadata-aware architecture.
In this abstraction, objects are our database tables. The fields on those objects are columns, and records are rows in the database.



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
* Know the different types of orgs
 `Production, Development and Testing environments `
 `Production has four types of licence which you can go up and down: Group, professional, enterprise and unlimited`
 `Force.com will either run on top of Enterprise or Unlimited Edition`
 `developer and sandbox editions not allow to convert to production` 
 `if we dont need CRM functionality then we can sign up for force.com seperately`
 ` developing environment use for developing and testing apps. developing can be done either in brower based ide or in force.com ide which is eclipse `
 
 
* Different ways to move metadata from one org to another.
* Schema Builder
