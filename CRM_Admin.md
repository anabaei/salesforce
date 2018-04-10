
## CPQ
* Configure, Price Quote. CPQ generates a pdf based on price and basic info 
* CPQ is created on opportunities
## Chatter
* Change chatter setting by `setup> Chatter Settings> edit > Select Allow Records in Groups (1) and Enable Unlisted Groups (2)`
* Create public group `chatter tab> Groups> new> save`
* Enable chatter email `setup> Email Settings> change > save`
* `Feed Tracking` Automatically announce any changes to records. 
* Enable and Customize feild tracking `setup> Feed Tracking> select Contact> enable feed tracking> up to 20 feilds> save`
* Chatter publisher includes the standard actions Post, File, Link, Poll, and Question.
* Add action then create action `setip>chatter settings>edit>Enable action in publisher> save` then add create `setup> global actions>new> create record, contract, typ: new[record], nameit> save` 
Then in layout `add customer signed date> save`
* Now add action to publisher as `Create > Global Actions > Publisher Layouts> global layout> drag new contact> save`
* Group publisher by default inherites the global layout( like what we have in chatters) to customize it `setup>group layout> edit>quick action> override publisher`
* An `approval process` is an automated process your organization can use to approve records in Salesforce. 
## Assess the Quality Data
* Missing Records, Duplicate Records, No Data Standards, Incomplete Records and old data can affect the data quality as [here](https://trailhead.salesforce.com/trails/getting_started_crm_basics/modules/data_quality/units/data_quality_getting_started)
* Develop data management plan
## Report
* Dashboard is a visual display and has 1:1 relation with report. However we can use single report for multiple dashboard. and multiple dashboard components can display as one dashboard page layout.
* Dashboard like reports are stored in folder which determines who can access.
* Each dashboard has running users and he is the one who controlls accessing others regardless of other's roles and profile settings
* Embed reports or dashboard into chatter to enable it `setup>feed tracking> enable checkbox` and `setup>Reports and Dashboard Settings> enable snapshot` and `Setup -> Chatter -> Feed tracking>dashboard>enable feed tracking and all 5 boxes` then if you go to snapshot you would have drop down to post component as snapshot as well
* install this app for more report [options](https://trailhead.salesforce.com/modules/reports_dashboards/units/reports_dashboards_appexchange) 
Then inside the salesforce adoption dashboards you have three new dashboards

