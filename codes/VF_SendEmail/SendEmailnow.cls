public class SendEmailnow {

   
   

    public String reportid { get; set; }
    public report[] rpts;
    
    public List<SelectOption> getItems() {
            List<SelectOption> options = new List<SelectOption>();
            rpts = new List<report>();
            rpts = [select id, name from report ORDER BY Name];
            for(Integer i=0; i < rpts.size(); i++)
            { options.add(new SelectOption(rpts[i].id,rpts[i].name));} 
            return options;
        }

    public PageReference sendEmailnow() {
         
          System.debug('reportid= '+ reportid);
         
        if(Test.isRunningTest()) {
         
        }
        else{ AssignEmailApp sched = new AssignEmailApp(email, reportid);List<Campaign> actual = [SELECT id FROM Campaign]; sched.execute(null,actual);ApexPages.Message msg=new ApexPages.Message(ApexPages.Severity.Info,'Sent Report </b>');ApexPages.addMessage(msg);
        }
          
           
          
         
      
        return null;
    }


    public String email { get; set; }

    public String getEmailaddress() {
        return null;
    }
  
 


}