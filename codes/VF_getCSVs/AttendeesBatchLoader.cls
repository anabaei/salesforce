Global class AttendeesBatchLoader implements Database.Batchable<sObject>,Database.AllowsCallouts  {
//                                           Database.Batchable<sObject>
// query string that is set in the ExampleScheduler (and ExampleController if one is created)
//
//public string query;
// Database.executeBatch() in ExampleScheduler call this start method
// global database.querylocator start(Database.BatchableContext BC) {   
//  return Database.getQueryLocator(query);
//  }
    
 public String query = 'select Id from Case';

 global database.querylocator start(Database.BatchableContext BC) {
     return Database.getQueryLocator(query);
  }
    
    global void execute(Database.BatchableContext BC, List<Case> scope) 
  
  {
   //callout3();
   ////////////////////////////////////
   //                              ///
   ///////////////////////////////////
  
         try {                  
          HttpRequest req = new HttpRequest();
          HttpResponse res = new HttpResponse();
          Http http = new Http();
          // Set values to Params

          String endpoint = 'https://www.sfu.ca/~anabaei/a.json';
          List<EventbriteList__c> acclist;
             
          //req.setHeader('Authorization', header);
          req.setHeader('Content-Type', 'application/json');
          req.setEndpoint(endpoint);
          req.setMethod('GET');
          req.setBody('Information you wanna send');
          req.setCompressed(true); // This is imp according to SF, but please check if
                                 // the webservice accepts the info. Mine did not :P
             
             // Had to set it to false
          
          if (!Test.isRunningTest()) {      
            res = http.send(req);
            String sJson = res.getBody();
            callout3(sJson);
              
            System.debug('Str:' + res.getBody());
            List<Object> m = (List<Object>)JSON.deserializeUntyped(res.getBody());
            System.debug('************=aa  '+m.size());
            
           for (Object item : m) 
       {
              Map<String, Object> i = (Map<String, Object>)item;
              // Map<String, Object> names = (Map<String, Object>) i.get('eventId');
              // String  name = String.valueof(names.get('text'));
               String eventid = (String) i.get('eventId');
               String eventName = (String) i.get('eventName');
               
               ////////////////////////////////////
                List<Object> attendeeData = (List<Object>) i.get('attendeeData');
                for (Object attendees : attendeeData) 
                {
                    Map<String, Object> j = (Map<String, Object>)attendees;
               //     Integer Order = (Integer) j.get('Order #');
               //     String OrderDate = (String) j.get('Order Date');
                    String FirstName = (String) j.get('First Name');
                    String LastName = (String) j.get('Last Name');
                    String Email = (String) j.get('Email');
                    Integer Quantity = (Integer) j.get('Quantity');
              //      String TicketType = (String) j.get('Ticket Type');
             //       String OrderType = (String) j.get('Order Type');
             //       Decimal TotalPaid = (Decimal) j.get('Total Paid');
             //       Decimal EventbriteFees = (Decimal) j.get('Eventbrite Fees');
                    Decimal EventbritePaymentProcessing = (Decimal) j.get('Eventbrite Payment Processing');
             //       String AttendeeStatus = (String) j.get('Attendee Status');
             //       String Waiver = (String) j.get('Waiver');
                    Set<String> keyValues = j.keySet();
               
               ////////////////////////////////
               EventbriteList__c accObj = new EventbriteList__c(); 
              // csvRecordData = eventit;
               accObj.eventId__c = eventid;  
               accObj.eventName__c = eventName;
               accObj.FirstName__c = FirstName;
               accObj.LastName__c = LastName;
               accObj.email__c = Email;
              // accObj.Attendee_Status__c = AttendeeStatus;
             //  accObj.order_id__c = String.valueOf(Order);
             //  accObj.Order_Type__c = OrderType;
               accObj.Quantity__c = String.valueOf(Quantity);
             //  accObj.Order_date__c = OrderDate;
             //  accObj.Total_Paid__c = String.valueOf(TotalPaid);
                  //  Object Question1 = (Object) attendees[7];
                    List<String> listStrings = new List<String>(keyValues);
                     
                  // System.debug('_____________________'+ listStrings + '_____________________');
                      for (Integer k=11; k < listStrings.size(); k++) 
                    {
                    
                      System.debug(listStrings[k]+ ' '+k);   
                      String value = String.valueOf((Object) j.get(listStrings[k]));
                      System.debug(value + ' '+k);
                      
                      if(listStrings[k] != 'Waiver')
                      {
                       //  if(k == 11){accObj.Question1__c = listStrings[k] + value;} 
                       //  if(k == 12){accObj.Question2__c = listStrings[k] + value;} 
                       //  if(k == 13){accObj.Question3__c = listStrings[k] + value;} 
                         if(k == 14){accObj.Question4__c = listStrings[k] + value;} 
                         if(k == 15){accObj.Question5__c = listStrings[k] + value;} 
                         if(k == 16){accObj.Question6__c = listStrings[k] + value;} 
                         if(k == 17){accObj.Question7__c = listStrings[k] + value;} 
                         if(k == 18){accObj.Question8__c = listStrings[k] + value;} 
                         if(k == 19){accObj.Question9__c = listStrings[k] + value;} 
                         if(k == 20){accObj.Question10__c = listStrings[k] + value;} 
                      }
                     
                     
                    }
              
              
               //accObj.attendeeData__c = attendeeData;
               /// for into attendeedata 
               /////
                    if(accObj != null){
                        acclist.add(accObj);         
                    }
               
               // JSONParser parser = JSON.createParser(attendeeData);
              //   System.debug(parser);
             
            }
        
       }
         insert acclist;              
             
              
              
          }             
          // now do what u want to with response.               
          }
          catch (Exception e) {         
            System.debug('Error:' + e.getMessage() + 'LN:' + e.getLineNumber() );           
          }
       
  ////////////////////////////////////
  ////                           /////
  ////////////////////////////////////    
  }  
       
  // after all batches have been executed, do any final cleanup tasks in this mehtod
 global void finish(Database.BatchableContext BC)
 {
 }

    public void callout3(String sc){
        System.debug('');
    }
}