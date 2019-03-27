public with sharing class EventbriteAttendees_controller {


  public List<String> chtmp { get; set; }
  
  public List<String> name { get; set; }
  public Integer num { get; set; }
   public Integer num2 { get; set; }
  public String[] headers { get; set; }
  //public String[] headerQs { get; set; }
  //public String questions { get; set; }
 
  public String ss { get; set; }
 // public String ss2 { get; set; }
  public HttpResponse ss3 { get; set; }
  public HttpResponse resp1 { get; set; }
  public HttpRequest req1 { get; set; }
  
  public Blob csvFileBody{get;set;}
  public string csvAsString{get;set;}
  public string[] csvRecordData;
  public String[] csvall{get;set;}
  public String[] csvFileHeaders{get;set;}
  //public String[] csvFileTemp{get;set;}
  //public String[] csvFileParts{get;set;}
  public String[] csvFileLines{get;set;}
  public String[] questionslist {get;set;}
  
  public List<EventbriteList__c> acclist{get;set;}
  public List<Object> m {get;set;}
  public List<Object> ss4 {get;set;}
  public Object ss5 {get;set;}
  public Map<String, Object> i {get;set;}
  public Set<String> header;
    
  public EventbriteAttendees_controller()
  {
    csvFileLines = new String[]{};
    acclist = New List<EventbriteList__c>();  
    header = new Set<String>{'Order #', 'Order Date', 'First Name','Last Name', 'Email', 'Quantity', 'Ticket Type' ,'Order Type','Total Paid', 'Eventbrite Fees', 'Eventbrite Payment Processing', 'Attendee Status', 'Waiver'};
    
    // HttpResponse res = getInfoFromEndPoint('https://www.sfu.ca/~anabaei/a.json'); //
    //
    //// In order to test end point  
    // HttpResponse res = getInfoFromEndPoint('http://localhost:8080/testService/json/');
    //ss5 = res.getBody(); // (Object)JSON.deserializeUntyped(res);
    
    // HttpResponse res = getInfoFromEndPoint('http://142.58.87.247:8000/');
    //  ss = res.getBody();
    // System.debug(res.getBody());
  }
  
    /////////

    public static HttpResponse getInfoFromEndPoint(String endpoint)
    {
        HttpRequest req = new HttpRequest();
        Http h = new Http();
        req.setEndpoint(endpoint);
        Blob headerValue = Blob.valueOf('amir' + ':' + '123');
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        
       
        return res;
    }
    
    
     public void hittheserver()
    {    
        
        //Http h = new Http();
        //HttpRequest req = new HttpRequest();
        //req.setMethod('GET');
        //req.setEndpoint('https://www.sfu.ca/~jtoering/eventbrite/eventBriteEvents.json');
        // HttpResponse res = getInfoFromEndPoint('https://www.sfu.ca/~jtoering/eventbrite/eventBriteEvents.json');
        
          HttpResponse res = getInfoFromEndPoint('http://142.58.87.247:8000/');
        // HttpResponse res = getInfoFromEndPoint('https://amirsfu.herokuapp.com/');
         
          
        
          m = (List<Object>)JSON.deserializeUntyped(res.getBody());
       
       for (Object item : m) 
       {
               i = (Map<String, Object>)item;
              // Map<String, Object> names = (Map<String, Object>) i.get('eventId');
              // String  name = String.valueof(names.get('text'));
               String eventid = (String) i.get('eventId');
               String eventName = (String) i.get('eventName');
              
               
               ////////////////////////////////////
                List<Object> attendeeData = (List<Object>) i.get('attendeeData');
                for (Object attendees : attendeeData) 
                {
                    Map<String, Object> j = (Map<String, Object>)attendees;
                    Integer Order = (Integer) j.get('Order #');
                    String OrderDate = (String) j.get('Order Date');
                    String FirstName = (String) j.get('First Name');
                    String LastName = (String) j.get('Last Name');
                    String Email = (String) j.get('Email');
                    Integer Quantity = (Integer) j.get('Quantity');
                    String TicketType = (String) j.get('Ticket Type');
                    String OrderType = (String) j.get('Order Type');
                    Decimal TotalPaid = (Decimal) j.get('Total Paid');
                    Decimal EventbriteFees = (Decimal) j.get('Eventbrite Fees');
                    Decimal EventbritePaymentProcessing = (Decimal) j.get('Eventbrite Payment Processing');
                    String AttendeeStatus = (String) j.get('Attendee Status');
                    String Waiver = (String) j.get('Waiver');
                    Set<String> keyValues = j.keySet();
               
               ////////////////////////////////
               EventbriteList__c accObj = new EventbriteList__c(); 
              // csvRecordData = eventit;
               accObj.eventId__c = eventid;  
               accObj.eventName__c = eventName;
               accObj.FirstName__c = FirstName;
               accObj.LastName__c = LastName;
               accObj.email__c = Email;
               accObj.Attendee_Status__c = AttendeeStatus;
               accObj.order_id__c = String.valueOf(Order);
               accObj.Order_Type__c = OrderType;
               accObj.Quantity__c = String.valueOf(Quantity);
               accObj.Order_date__c = OrderDate;
               accObj.Total_Paid__c = String.valueOf(TotalPaid);
               
              
                  ///////////////////////////////////
                  ///// assign dynamic columns //////
                  ///////////////////////////////////
                  //Set<String> kvs = keyValues;
                  //kvs.removeall(headers);
                  //
                  //for ( k in kvs)
                  //{
                  
                  //}
                  //
                  ///////////////////////////////////
                  /////                        //////
                  ///////////////////////////////////
                  
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
                         if(k == 11){accObj.Question1__c = listStrings[k] + value;} 
                         if(k == 12){accObj.Question2__c = listStrings[k] + value;} 
                         if(k == 13){accObj.Question3__c = listStrings[k] + value;} 
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
                acclist.add(accObj);
               // JSONParser parser = JSON.createParser(attendeeData);
              //   System.debug(parser);
             
        }
        }
         insert acclist;
       // System.debug(m[0]);
        
        // then feed the return into a loop to go chck whether each one exists or not, if not created 
    }
  
  
  public void deleteall()
  {
    List<EventbriteList__c> temp = [Select id from EventbriteList__c];
    delete temp;
    System.debug(temp);
  }
  
 
  
  /////////
         
  public void importCSVFile()
  {
  
       try{
           csvAsString = csvFileBody.toString(); csvAsString  = csvAsString.replaceAll('\n\n',' ');
           // ss = csvAsString;
           
           chtmp = csvAsString.split('\n');
           // String[] csvFileLines = csvAsString.split('\n'); 
          
           num = chtmp.size();
           
           csvall = csvAsString.split(',');
          
            
            
              headers = chtmp[0].split(',');
             
            
             Integer j=1;
           do{
              // Account accObj = new Account();    
               if( csvall[j] == 'Attendee Status')
               {
               num = j; // questions start from here
               }
            j++;   
           }while(j<chtmp.size());
           
           num2 = headers.size();
           
              for(Integer jj=num;jj<headers.size();jj++)
           {

           }
           
           name = questionslist;
         //  csvFileHeaders = csvAsString.split('\\d{4,9}+');
           csvFileHeaders = csvAsString.split(',');
          
             csvFileLines = chtmp;
           
          // accObj.Order_Type__c = csvRecordData[7];
           for(Integer i=1; i<csvFileLines.size(); i++) {
               EventbriteList__c accObj = new EventbriteList__c();  csvRecordData = csvFileLines[i].split(',');accObj.order_id__c = csvRecordData[0];  accObj.order_Date__c = csvRecordData[1]; accObj.FirstName__c = csvRecordData[2];  accObj.LastName__c = csvRecordData[3];accObj.email__c = csvRecordData[4];accObj.Quantity__c = csvRecordData[5]; accObj.Ticket_Type__c = csvRecordData[6];   accObj.Total_Paid__c = csvRecordData[8]; accObj.Eventbrite_Fees__c = csvRecordData[9]; accObj.Eventbrite_Payment_Processing__c = csvRecordData[10];  // accObj.Attendee_Status__c = csvRecordData[11]; 
          
               if(num2 > 12){accObj.Question1__c = headers[12] + csvRecordData[12];  }
               if(num2 > 13){ accObj.Question2__c = headers[13] + csvRecordData[13];}
               if(num2 > 15){ accObj.Question3__c = headers[14] + csvRecordData[14];} 
               if(num2 > 15){ accObj.Question4__c = headers[15] + csvRecordData[15];} 
               if( num2 > 16){ accObj.Question5__c = headers[16] + csvRecordData[16];}if( num2 > 17){ accObj.Question6__c = headers[17] + csvRecordData[17];}if( num2 >18){  accObj.Question7__c = headers[18] + csvRecordData[18];}if(num2 > 19){accObj.Question8__c = headers[19] + csvRecordData[19]; } if( num2 > 20){accObj.Question9__c = headers[20] + csvRecordData[20]; }                                                                       
               acclist.add(accObj);   
           }
        insert acclist;
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
        }  
  }
 
}