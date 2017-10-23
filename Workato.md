### Eventbrite vs Salesforce using Workato
##### Requirements
* You have an account with Eventbrite which has at least one event listed and you aim to map it to your salesforce account (clearly you should have one salesforce account as well). Also you access to appexchange and can install workato and create one account with your salesforce autentications in that, here is the [link](https://appexchange.salesforce.com/listingDetail?listingId=a0N30000000pvqUEAQ) 
* After insalling workato from appexchange you should see landing page like this, finally your receipe would be like the current one 
* Click on Create new recipe to start 
![alt text](https://user-images.githubusercontent.com/7471619/31692692-b259d960-b34f-11e7-80ce-a55dd532b125.png)
-------
* Select Eventbrite as a trigger applcation from drop down
* Select new event created as trigger function, you can select any other actions 
![alt text](https://user-images.githubusercontent.com/7471619/31692710-ca4247ec-b34f-11e7-87ff-c1c340863016.png)
-------
* Then it ask you to connect with eventbrite action 
![alt text](https://user-images.githubusercontent.com/7471619/31692722-db8a53c8-b34f-11e7-88ca-eb18a96e559e.png)
-------
* Then it ask you to select destination app from drop down which we choose salesforce 
![alt text](https://user-images.githubusercontent.com/7471619/31692751-02090896-b350-11e7-9f81-49ce9894b57d.png)
-------
* Then you have to choose what action or method it needs to be done and select the object of that action and which attribute has to be used to create that object from and press next 
![alt text](https://user-images.githubusercontent.com/7471619/31692771-164a012a-b350-11e7-8f9e-4c2344610df2.png)
-------
* At the end your settings should be like this
![alt text](https://user-images.githubusercontent.com/7471619/31692777-1fe59398-b350-11e7-8ea9-09c50e413046.png)
-------
* To check the correctness of that you can run test as clicking on Test receipe button on the right corner
![alt text](https://user-images.githubusercontent.com/7471619/31692777-1fe59398-b350-11e7-8ea9-09c50e413046.png)
-------
* Now if there is no error and you already have created one event in your eventbrite account then you should see them in job lists as below, I already have created two events so they listed
![alt text](https://user-images.githubusercontent.com/7471619/31692792-34c8a0ac-b350-11e7-9571-b8ca0aeae00b.png)

##### on Salesforce account 
* Go to your account and check the campaign tab on sales, then you should see the even created as below 
* Notice: some cases you may need to modify or create new view to actually see the event, but regardless of views you should see the campaign on left side menu
-------
![alt text](https://user-images.githubusercontent.com/7471619/31692806-424df25e-b350-11e7-931d-7c2805616713.png)
* If you click the campaign just created you should see the details of that as below 
-------
![alt text](https://user-images.githubusercontent.com/7471619/31692816-4d4b4602-b350-11e7-8c41-64600b6ad16a.png)
------
### Opportunities
* Each campaigns includes opportunities who purchased the tickets from the events, to map ticketets to events define trigger as new event 
* Define action application as salesforce and the action as create an object and define that object as opportunity
attendee registered in Eventbrite 
![alt text](https://user-images.githubusercontent.com/7471619/31735182-f3953f0e-b3f5-11e7-9259-b1fc0840573f.png)
-----
* Define the close date and attribute for object to be presentedby and also most important the campaign ID which you have it from salesforce view 
![alt text](https://user-images.githubusercontent.com/7471619/31735301-576b3038-b3f6-11e7-8e9e-867ca0d97c98.png)
-----
* After running the test, as you see the campaign id is same and in details page you see the opportunities for that campaing 
![alt text](https://user-images.githubusercontent.com/7471619/31735394-a1defdfc-b3f6-11e7-9161-76f3f1d3de9c.png)
![alt text](https://user-images.githubusercontent.com/7471619/31735543-1744223e-b3f7-11e7-8c5c-0cf113bb49c2.png)
-------
#### Create Campaign with an Event Trigger
* When an event was created in Eventbrite then create a campaign in Salesforce as 
![alt text](https://user-images.githubusercontent.com/7471619/31917714-d72a9e9c-b80d-11e7-8606-651ee82dc3c4.png)
* Add optional Event Id to be able to keep track of the Event 
![alt text](https://user-images.githubusercontent.com/7471619/31917559-0d46c5c4-b80d-11e7-8c34-e469b9617280.png)
* The result of executing this receipe would be 
![alt text](https://user-images.githubusercontent.com/7471619/31917553-0843052e-b80d-11e7-8e87-762ad3f50a42.png)
#### Create contacts when new attendee registered 
![alt text](https://user-images.githubusercontent.com/7471619/31917566-11c0df36-b80d-11e7-87e8-59a47abba33c.png)
* Same as campaign add Event ID attribute to be able to track each contacts 
![alt text](https://user-images.githubusercontent.com/7471619/31917571-15a116c0-b80d-11e7-8190-bad786332454.png)
* The result of running this receipe would be new contacts in salesforce 
![alt text](https://user-images.githubusercontent.com/7471619/31917549-05b49c8c-b80d-11e7-8a8e-c7845fb5985e.png)
#### Managing campaigns members 
* Inside campaign edit tab click on `add members`
* Select the contatcs from step 1 and next steps would be customizing filter by Event Id eqalus to our ids then press `Go`
![alt text](https://user-images.githubusercontent.com/7471619/31917556-0acfddd0-b80d-11e7-98aa-1aa2a42c92db.png)
* Result would be as below 
![alt text](https://user-images.githubusercontent.com/7471619/31917583-1d6752fc-b80d-11e7-9eff-2f74869e24d9.png)
* By selecting sent then all contacts would be as members of the campaign 
----------



