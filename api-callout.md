### Callout API end point 
* Create a controller for callout and define a function 


```java
public class PositionsController {
    public void GetCandidatePositions() {
        // Instantiate a new http object
        Http h = new Http();
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://www.eventbriteapi.com/v3/users/me/?token=XXXXXXXXXXXXXX');
```
        req.setMethod('GET');
        // how to overcome 301 issu
        // make another request to new location, if it returns back then call it again
       
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        if(res == null) {  System.debug('responseJson'); }
        //
       System.debug(res);
        String responseJson = res.getBody();
        
        List<String> thelist = new List<String>();
        
         String loc = res.getHeader('Location'); // get location of the redirect
        System.debug(loc); 
         req = new HttpRequest();
         req.setEndpoint('https://www.eventbriteapi.com/v3/users/me/?token=BOJPDFI7HSHDCV6WQZAL');
         req.setMethod('GET');
         req.setHeader('Content-Type', 'application/json');
         req.setHeader('Accept','application/json');
         res = h.send(req);
        // req.setHeader('Authorization', 'bearer RH6XM72RQUHAWJSZUSS2');
       //  System.debug(res.getBodyAsBlob());
         System.debug(res.getBody());
        
        //create map to hold results
      //     Object m = (Object)JSON.deserializeUntyped(res.getBody());
         Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
      //  Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(getJsonToParse());
     
        //extract the positions in the result set
         List<Object> positions = (List<Object>) m.get('emails');
        
        String positionString = '';
           for (Object item : positions) {
           Map<String, Object> i = (Map<String, Object>)item;
     ///   System.debug(i.get('created'));
           System.debug(i.get('email'));
     ///   System.debug('created');
        }
        
        //loop through all the positions
       // for (Object s : positions) {
            
         //   positionString += '<span class=\'card\'>' + string.valueof(positions) + '</span>';
       // }
       //   positionString += '<span class=\'card\'>' + positions + '</span>';
        //set string to positions variable
       // PositionsList = positionString;

    }

}
