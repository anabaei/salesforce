```java
public class SaveCampagins {

    public String info { get; set; }
    private String Ordersinfo;
    private String Ordersinfo1;
    private Contact[] cc;
    private String email;
    private String phone;
    private String suffix;
    private String mobile;
    private Date birthdate;
    private String eventId;
    private String idforcam;
    private String Eventinfo;
    private String name;
    private String details;
    private String startdate;
    private String enddate;
    private String status;
    private String createdat;
    private String questionfor;
     public String answersfor; 
    private String cellphone;
    private String jobtitle;
    private String age;
    private String[] temp;
    private String[] tempbd;
    private String[] tempenddate;
    private String[] tempmore;
    private Contact[] tempid;
    private Campaign[] tempcamid;
    private String contactFirstName;
    private String contactLastName;
    private String contactemail;
    private String contactaffiliate;
    private String workphone;    
    private String mailhomeaddress;
    private String mailhomeaddress2;
    private String mailhomepo;
    private String mailhomeregion;
    private String mailhomecountry;
    private String mailhomecity;
    private String bd;
    private Date bd2;
    private Date bd3;
    private String birthdate1;
    private String blog;
    private String website;
    private String ticketname;
    
    //public accessor
   // List<Contact> contacts = new List<Contact>();
    //function called by view
    public SaveCampagins()
    {
      eventId = ApexPages.currentPage().getParameters().get('Id'); 
      name = ApexPages.currentPage().getParameters().get('name');
      startdate = ApexPages.currentPage().getParameters().get('startdate');
      enddate = ApexPages.currentPage().getParameters().get('endddate');
      status = ApexPages.currentPage().getParameters().get('status');
      createdat = ApexPages.currentPage().getParameters().get('createdat'); 
      
      temp = startdate.split('T');           
      temp = temp[0].split('-'); 
       
     
    }
    public String createcontacts() {
       
      
       
       Http h = new Http();

        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'bearer BOJPDFI7HSHDCV6WQZAL');
        req.setEndpoint('https://www.eventbriteapi.com/v3/events/'+ eventId +'/attendees/?token=BOJPDFI7HSHDCV6WQZAL');
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        String responseJson = res.getBody();
        List<String> thelist = new List<String>();
         String loc = res.getHeader('Location'); // get location of the redirect
         req = new HttpRequest();
         req.setEndpoint('https://www.eventbriteapi.com/v3/events/'+ eventId +'/attendees/?token=BOJPDFI7HSHDCV6WQZAL');
         req.setMethod('GET');
         req.setHeader('Content-Type', 'application/json');
         req.setHeader('Accept','application/json');
         res = h.send(req);
         Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        List<Object> attendees = (List<Object>) m.get('attendees');
         
      //   Ordersinfo += '<table class=\'table table-hover\'>';
      //   Ordersinfo += '<tr> <th class=\'tr\'>First Name</th> <th class=\'tr\'>Last Name</th>  <th class=\'tr\'>Email</th>  <th class=\'tr\'>Affiliate</th>  <th class=\'tr\'>Status</th>  <th class=\'tr\'>Ticket Type</th><th class=\'tr\'>Created At</th><th class=\'tr\'>Ticket Barcode</th><th class=\'tr\'>Fee</th><th class=\'tr\'>Action</th></tr>';
        for (Object item : attendees) {
            
            
           Map<String, Object> i = (Map<String, Object>)item;
                   Map<String, Object> profile = (Map<String, Object>) i.get('profile');
                      // get the name of the events
                     // System.debug(profile.get('first_name'));
                     
                        
                     // List<List<Contact>> searchList = [FIND 'Testerx4@gmail.com' IN email FIELDS RETURNING Contact (email)];
                      // searchList[0]
                      // 
                       
                      contactLastName = String.valueof(profile.get('last_name'));
            
                   //   Ordersinfo += '<td class=\'tr\'>'+ profile.get('first_name') + '</td>';
                   //   Ordersinfo += '<td class=\'tr\'>'+ profile.get('last_name') + '</td>';
                  //    Ordersinfo += '<td class=\'tr\'>'+ profile.get('email') + '</td>';
                      email = String.valueOf(profile.get('email'));
                      blog = String.valueOf(profile.get('blog'));
                      age = String.valueOf(profile.get('age'));
                      ticketname = String.valueOf(i.get('ticket_class_name'));
            
                      phone = String.valueOf(profile.get('home_phone'));
                      cellphone = String.valueOf(profile.get('cell_phone'));
                      jobtitle= String.valueOf(profile.get('job_title'));
                      age = String.valueOf(profile.get('age'));
                      suffix = String.valueOf(profile.get('suffix'));
                      website = String.valueOf(profile.get('website'));
                      
                      workphone = String.valueOf(profile.get('work_phone'));
                      String tm1 = String.valueOf(profile.get('birth_date'));
                 //     tempbd = tm1.split('-');
                   //   bd = bd2.month()+'/'+bd2.day()+'/'+bd2.year(); 
                   //   bd3 = date.parse(bd);
                     //  bd = String.valueOf(bd.split('-'));
                   //   tempbd = bd.split('-');
                   //   suffix = String.valueOf(profile.get('suffix'));
                   //   mobile = String.valueOf(profile.get('cell_phone'));
                     // birthdate = Date.valueOf(profile.get('birth_date'));
                     // String nnn =  birthdate.format('mm/dd/yyyy');
                 //     Ordersinfo += '<td class=\'tr\'>'+ i.get('affiliate') + '</td>';
                //      Ordersinfo += '<td class=\'tr\'>'+ i.get('status') + '</td>';
                //      Ordersinfo += '<td class=\'tr\'>'+ i.get('ticket_class_name') + '</td>';
                //      Ordersinfo += '<td class=\'tr\'>'+ i.get('created') + '</td>';
                    
                     
                      
                      Map<String, Object> addresses = (Map<String, Object>) profile.get('addresses');
                   //  mailhomeaddress =  String.valueof(addresses);
                     if (addresses != null){
                        Map<String, Object> homeaddress = (Map<String, Object>) addresses.get('home'); 
                         mailhomeaddress =  String.valueof(homeaddress.get('address_1'));
                         mailhomeaddress2 =  String.valueof(homeaddress.get('address_2'));
                         mailhomepo =  String.valueof(homeaddress.get('postal_code'));
                         mailhomeregion =  String.valueof(homeaddress.get('region'));
                         mailhomecountry =  String.valueof(homeaddress.get('country'));
                         mailhomecity =  String.valueof(homeaddress.get('city'));
                     }
                          
                     // mailhomeaddress =  homeaddress.get()
            
                      List<Object> barcodes = (List<Object>) i.get('barcodes');
                      Map<String, Object> j = (Map<String, Object>)barcodes[0];
               //       Ordersinfo += '<td class=\'tr\'>'+ j.get('status') + '</td>';
                    //  System.debug(barcodes);
                      Map<String, Object> costs = (Map<String, Object>) i.get('costs');
                      Map<String, Object> base_price = (Map<String, Object>) costs.get('base_price');
                 //     Ordersinfo += '<td class=\'tr\'>'+ base_price.get('display') + '</td>';
                      
                      
                       answersfor = ' ';                      
                       List<Object> answers = (List<Object>) i.get('answers');
                          for (Object ans : answers) {
                           Map<String, Object> a1 = (Map<String, Object>)ans;
                          
                             
                          if (a1.get('answer') == null)
                          {
                           
                          Ordersinfo += '<td class=\'tr\'>'+ '<span class=\'question\'>'  + 
                           a1.get('question')+  '</span>'  +' <br /> ' +
                           '<span class=\'answer\'> </span></td>'; 
                          }
                          else 
                          {
                          
                      //    Ordersinfo += '<td class=\'tr\'>'+ '<span class=\'question\'>'  + 
                      //     a1.get('question')+  '</span>'  +' <br /> ' +
                      //     '<span class=\'answer\'>'+ a1.get('answer') + '</span></td>'; 
                           
                          // questionfor += '/'+ a1.get('question')+'? '+a1.get('answer');  
                           answersfor += ','+ a1.get('question')+'? '+a1.get('answer');   
                          }
                          
                              
                          }
                      
                      
                      
          //     List<Contact>  cc = [Select email from Contact where email LIKE :email]; 
               
             //  List<Campaign>  cc = [Select name from Campaign where name LIKE 'alafi']; 
         //     if (cc.isEmpty()) {                                   
         //       Ordersinfo += '<td class=\'tr\'> <button type="button" class="btn btn-default"><a href=\'https://c.na73.visual.force.com/apex/Editorders?orderId='+ i.get('id')+'&eventId='+eventId+' \'>Add</a></button></td></tr>';
         
         //       }
        //    else {
        //        Ordersinfo += '<td class=\'tr\'></td></tr>';
                
        //    }
            
            ////// find campaigns ......
             
             tempcamid = [select id from Campaign where Name like: name limit 1 ];
           //   contactLastName = tempcamid.get(0).id;
            if (tempcamid.size() > 0){
                idforcam = tempcamid.get(0).id; 
            } 
            else
            {
                 Campaign new1 = new Campaign(Name= name, 
                          Status = status,
                          StartDate = date.parse(temp[1]+'/'+temp[2]+'/'+temp[0])
                                   
                              );
                insert new1;
                 idforcam = tempcamid.get(0).id;
            }
            
            //String idforcam = tempcamid.get(0).id;
         //  bd2 = date.parse(tempbd[1]+'/'+tempbd[2]+'/'+tempbd[0]);
            ////// create contacts ......
            Contact new1 = new Contact(LastName = contactLastName,  Email = email,  HomePhone = phone
                                      ,MobilePhone = cellphone
                                      ,Title = jobtitle
                                      , phone = workphone
                                       ,Department = bd
                                       , Birthdate = date.parse('12/14/1999')
                                       , MailingStreet = mailhomeaddress
                                       , MailingCity = mailhomecity
                                       , MailingState = mailhomeregion
                                       , MailingCountry = mailhomecountry
                                       , MailingPostalCode = mailhomepo
                                       , Description = 'age: '+ age +', '+ 'ticket type: '+ ticketname  
                                              + 'suffix: ' +', ' + suffix
                                             
                                              + 'website: ' +', ' + website
                                              +' blog: ' + blog +', '
                                              +' birthdate: ' + tm1 
                                      );
                                     
          
            try{
            insert new1; 
             tempid = [select id from Contact where LastName Like: contactLastName limit 1]; 
             String idforcontact = tempid.get(0).id;
             Savepoint sp = Database.setSavepoint();  // '7011I000000d2Xl'
                CampaignMember newt = new CampaignMember(CampaignId = idforcam, ContactId= idforcontact , Status='Opt-In',
                                                    answers__c = answersfor
                                                   );
                                   
                                             
                               try {
           							 insert newt;
                                     
         						  }
         				      catch(dmlexception e) {
          				      System.debug(e);
         					    Database.rollback(sp);
          				   }
           			 }
           catch(exception e){
                System.debug(e);
            }
            ////// find the contact id already created ......
         //   tempid = [select id from Contact where LastName Like: contactLastName limit 1];
          //  tempid = [select id from Contact where LastName Like: 'ssec' limit 1];
         //   String idforcontact = tempid.get(0).id;
            
            
            
           //   String idforcam = '7011I000000d2PB';     
           // create campaign memebr from the contact 
           
          //  Savepoint sp = Database.setSavepoint();
            ////// create campaignMember if duplicate rollback  ......
       //     CampaignMember newt = new CampaignMember(CampaignId = idforcam, ContactId= idforcontact , Status='Opt-In',
        //                                            answers__c = answersfor
        //                                           );
        //   try {
        //    insert newt;
        //   }
         ///    catch(dmlexception e) {
         //       System.debug(e);
         //    Database.rollback(sp);
   
           //  }
           }
        
                Ordersinfo += '</table>';
        return Ordersinfo;
    }
    
    
    
    
    
    public void createcamp(){
        /// get info to create it from end point 
        
        createcontacts();
        
     //   Campaign new1 = new Campaign(Name= name, 
     //                     Status = status,
     //                     StartDate = date.parse(temp[1]+'/'+temp[2]+'/'+temp[0])
     //                              
     //                         );
     //           insert new1; 
    }
    
  
     
     
}
```
