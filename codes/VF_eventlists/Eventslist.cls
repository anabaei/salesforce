public class Eventslist {

    public List<Campaign> listofallcampaign;
    //private variable
    private String Eventinfo;
    private String name;
    private String details;
    private String startdate;
    private String enddate;
    private String status;
    private String createdat;
    private String urllink,urlupdate;
    private String id;
    private String description;
    List<object> findcamp;
    private Campaign[] tempcamid;
    public String idString {get;set;}
    public String a;
    public String b;
    List<String> fff;
    private String capacity;
    private String fullname;
    private Boolean is_free;
    private Integer attendessppl;
    private Integer campaignmem;
    private String[] temp;
    private String temattendees;
    private Integer dupattendees;
    private Integer pagenumber= 1;
    private Boolean hasanotheroner = false;
    private Integer objectcount,tmcmrp ;
    private Integer pagecount = 1;
    Private String test;

    public String Getlists(){
      return Eventinfo;
    }

    // Contstructure for Eventlists
     public Eventslist()
    {
        /// save all list of campaigns in an array
         listofallcampaign = [SELECT Name,id,eventbriteid__c,repeatedmems__c FROM Campaign];

    }

 
    
    
    
    public Integer calcampaignmem(String eventId){
            tmcmrp = 0;
            String  cmpid = null;
             for(Campaign tempcam: listofallcampaign)
             {
                 if (tempcam.eventbriteid__c == eventId)
                 {
                  tmcmrp =  Integer.valueOf(tempcam.repeatedmems__c);
                  cmpid = tempcam.id;
                     break;
                 }

             }

            //  dd = [select Id,repeatedmems__c from Campaign where eventbriteid__c Like: eventId];

       // try{
       //     if (dd != null && dd.get(0).repeatedmems__c >0 ){
       //         tmcmrp = Integer.valueOf(dd.get(0).repeatedmems__c);
       //     }
       //   }
       // catch(exception e){

       // }
      //  if( !dd.isEmpty()){
         //   String  iee = String.valueOf(dd.get(0).id);
            // list all campaignmembers for that campaign name
            List<CampaignMember> tempcamid = [select CampaignId from CampaignMember where CampaignId=: cmpid ];

      //      return (tempcamid.size() + tmcmrp) ;
      //  }
        if (tempcamid != null && tempcamid.size() > 0)
        {
       //      return tmcmrp != 0? tempcamid.size() + tmcmrp: tempcamid.size();
           // test =String.valueOf(tempcamid.size());
            return tempcamid.size();
        }
        else {return 0;}
    }
    
    public void assignvars(Object item)
    {
        try{
                          Map<String, Object> ii = (Map<String, Object>)item;
                           Map<String, Object> names = (Map<String, Object>) ii.get('name');
                         name = String.valueof(names.get('text'));

                         fullname = String.valueof(names.get('text'));

                         Map<String, Object> descriptions = (Map<String, Object>) ii.get('description');
                         description = String.valueof(descriptions.get('text'));

                        capacity = String.valueof(ii.get('capacity'));
                        is_free = Boolean.valueOf(ii.get('is_free'));
                         Map<String, Object> starts = (Map<String, Object>) ii.get('start');
                           startdate = String.valueof(starts.get('local'));
                         Map<String, Object> ends = (Map<String, Object>) ii.get('end');
                            enddate = String.valueof(ends.get('local'));
                         createdat = String.valueof(ii.get('created'));
                         status = String.valueof(ii.get('status'));
                         urllink = String.valueof(ii.get('url'));
                         id = String.valueof(ii.get('id'));
        }
        catch(exception error){
            
        }
        
    }
    

    /// function to calculate each event attendees
    public Integer calattendees(String eventId){


         //Set<String> contactLastName;
        Set<String> contactLastName = new Set<String>{};
            
        dupattendees = 0;
        
      
            
         Http h = new Http();
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        // BOJPDFI7HSHDCV6WQZAL     sfu token: 7HZG7FTKQ4UMA7BOVIVV
        req.setHeader('Authorization', 'bearer 7HZG7FTKQ4UMA7BOVIVV');
        req.setEndpoint('https://www.eventbriteapi.com/v3/events/'+ eventId +'/attendees/?token=7HZG7FTKQ4UMA7BOVIVV');
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        String responseJson = res.getBody();
        List<String> thelist = new List<String>();
         String loc = res.getHeader('Location'); // get location of the redirect
         req = new HttpRequest();
       //  eventId = '39878463558';
         eventId = id;
         req.setEndpoint('https://www.eventbriteapi.com/v3/events/'+ eventId +'/attendees/?token=7HZG7FTKQ4UMA7BOVIVV');
        
      // https://www.eventbriteapi.com/v3/events/35830195078/attendees/?token=7HZG7FTKQ4UMA7BOVIVV
         req.setMethod('GET');
         req.setHeader('Content-Type', 'application/json');
         req.setHeader('Accept','application/json');
         res = h.send(req);
         Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
         Map<String, Object> paginations = (Map<String, Object>) m.get('pagination');
         String endpnts = 'https://www.eventbriteapi.com/v3/events/'+ id +'/attendees';
        
       // it gives error 
          HitServerAttend act1 = new HitServerAttend();
       // Map<String, Object> m = act1.hittheserver(endpnts, '7HZG7FTKQ4UMA7BOVIVV');
       // Map<String, Object> paginations = (Map<String, Object>) m.get('pagination');
         
       
                  //   hasanotheroner = Boolean.valueof(paginations.get('has_more_items'));
           if (paginations != null ) {
                       pagenumber = Integer.valueof(paginations.get('page_number'));
                       hasanotheroner = Boolean.valueof(paginations.get('has_more_items'));
                       objectcount  = Integer.valueof(paginations.get('object_count'));
                       pagecount =  Integer.valueof(paginations.get('page_count'));
           }
         //////////////////////////////////////////////////////////////////////////////////////////

         List<Object> attendees = (List<Object>) m.get('attendees');

        if (attendees.size() == 0){ return 0;}
        else {
          // calculate if two attendees has same email address or not
        for (Object item : attendees)
        {
           Map<String, Object> i = (Map<String, Object>)item;

                   Map<String, Object> profile = (Map<String, Object>) i.get('profile');
                   temattendees = String.valueof(profile.get('email'));
                   contactLastName.add(temattendees);
        }
         if (contactLastName != null && contactLastName.size() != attendees.size())
            {
                dupattendees = attendees.size() - contactLastName.size();
            }

       //  return  contactLastName.size();
         return  objectcount;
        }
    }
    
    public String assign_pos(String uris, String idcall, String position){
                   position += '<td><a href='+ uris +'?Id='+ idcall +
                  '&name='+ name +
                  '&startdate='+startdate+
                  '&enddate='+enddate+
                  '&status='+status+
                  '&description='+description+
                  '&capacity='+capacity+
                   '&is_free=' +is_free+ 
                   '&fullname='+fullname+
                   '&hasanotheroner='+ hasanotheroner +
                   '&pagecount='+ pagecount +
                  '&createdat='+createdat+' \' class=\'update\'> update </a></td>';
        
                  return position;
    }
    
    
    public String createtable(List<Object> positions){
        
        String positionString = '<table class=\'table-bordered table-hover th\'>';
         positionString += '<tr> <th class=\'tr\'>Sync</th><th class=\'tr\'>Event Name</th>' +

             '<th class=\'tr\'>Campaign memebers</th>'+
             '<th class=\'tr\'>Eventbrite attendees</th>' +
              '<th class=\'tr\'>Status</th> ' +
             '<th class=\'tr\'>Start Date</th>  <th class=\'tr\'>End Date</th>   <th class=\'tr\'>Created at</th>  <th class=\'tr\'>Link to Event</th></tr>';

        for (Object item : positions) {
                         assignvars(item);
                         attendessppl =  calattendees(id);
                         campaignmem  =  calcampaignmem(id);

               //////////////// Check campaign exists /////////////////
            Set<String> sds = new Set<String>();


            ///

            // check campaign already exist or not, if yes assign temporay id to campaign id 
            Campaign temids=null;
            for (Campaign ids: listofallcampaign)
            {
              if (ids.eventbriteid__c == id)
              {
                   temids = ids;
              }
            }

            if(temids == null){
                 // create campaign 
               positionString += '<td><a href=\'https://c.cs68.visual.force.com/apex/notsaveorders?Id='+ id +
                  '&name='+ name +
                  '&startdate='+startdate+
                  '&enddate='+enddate+
                  '&status='+status+
                  '&description='+description+
                  '&capacity='+capacity+
                   '&is_free=' +is_free+ 
                   '&fullname='+fullname+
                   '&hasanotheroner='+ hasanotheroner +
                   '&pagecount='+ pagecount +
                  '&createdat='+createdat+' \' class=\'update\'> update </a></td>';
               
                
             //  String uris = 'https://c.cs68.visual.force.com/apex/notsaveorders';
              
              //  positionString += assign_pos(uris,id,positionString);
                // have to add it here as well

            }else if (attendessppl > campaignmem )
            {
                if(Integer.valueOf(pagecount) ==1) {
                  // add attendees
                  urlupdate = 'notsaveorders';
                      }
                else if(Integer.valueOf(pagecount) ==2) {
                     urlupdate =  'notsaveorders2';
                      }
                else if(Integer.valueOf(pagecount) ==3) {
                     urlupdate =  'notsaveorders3';
                      }
                else if(Integer.valueOf(pagecount) ==4) {
                     urlupdate =  'notsaveorders4';
                      }
                else if(Integer.valueOf(pagecount) ==5) {
                     urlupdate =  'notsaveorders5';
                      }
                else if(Integer.valueOf(pagecount) ==6) {
                     urlupdate =  'notsaveorders6';
                      }
                else {
                     urlupdate =  'notsaveorders';
                      }
                  positionString += '<td><a href=\'https://c.cs68.visual.force.com/apex/'+urlupdate+'?Id='+ id +
                  '&name='+ name +
                  '&startdate='+startdate+
                  '&enddate='+enddate+
                  '&status='+status+
                  '&description='+description+
                  '&capacity='+capacity+
                   '&is_free=' +is_free+
                   '&fullname='+fullname+
                   '&hasanotheroner='+ hasanotheroner +
                   '&pagecount='+ pagecount +
                  '&createdat='+createdat+' \' class=\'update\'> update </a></td>';
            }
            else
            {
               
                     urlupdate =  'notsaveorders';
                    
                 positionString += '<td><a href=\'https://c.cs68.visual.force.com/apex'+urlupdate+'?Id='+ id +
                 '&name='+ name +
                   '&startdate='+startdate+
                  '&enddate='+enddate+
                  '&status='+status+
                  '&description='+description+
                  '&capacity='+capacity+
                   '&is_free=' +is_free+
                   '&fullname='+fullname+
                   '&hasanotheroner='+ hasanotheroner +
                   '&pagecount='+ pagecount +
                  '&createdat='+createdat+' \' class=\'okay\' target="_blank"> Ok </a></td>';
            }
            
            
            
               positionString += '<td class=\'tr\'>'+ name +  '</td>';
               positionString += '<td class=\'tr\'>'+ campaignmem + '</td>';
               positionString += '<td class=\'tr\'>'+ attendessppl + '</td>';
               positionString += '<td class=\'tr\'>'+ status + '</td>';
               positionString += '<td class=\'tr\'>'+ startdate + '</td>';
               positionString += '<td class=\'tr\'>'+ enddate + '</td>';
               positionString += '<td class=\'tr\'>'+ createdat + '</td>';
            // positionString += '<td class=\'tr\'>'+ ends.get('local') + '</td>';
               positionString += '<td><button><a href=\''+ urllink + '\'>Event</a></button></td></tr>';

        }

        positionString += '</table>';
       
      //  System.debug('_____'+Eventinfo+'_______');
     // creme();
       return positionString;

    }
    
    //function called by view
    public String GetEventinfo() {

        //List<Object> positions = hitserver('1');
        ////// Hiting the endpoints /////
        HitServer act = new HitServer();
        Map<String, Object> m  = act.hittheserver('1','https://www.eventbriteapi.com/v3/users/me/owned_events','7HZG7FTKQ4UMA7BOVIVV');
        List<Object> positions = (List<Object>) m.get('events');        
        ////// -      - /////////
       return createtable(positions);
        
          
          
    }


}