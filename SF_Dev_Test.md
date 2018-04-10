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
* With/without sharing and how that's enforced up an execution context
* Best testing practices (design and annotations)
* The order of execution 
* Schema and Database classes
* Knowing when to use workflows/Process Builder/triggers/formula fields
* security is enforced across different types of object relationships
* Know the different types of orgs
* Different ways to move metadata from one org to another.
* Schema Builder
