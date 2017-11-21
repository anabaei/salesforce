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
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        String responseJson = res.getBody();
```
* However some cases like Eventbrite they return `error 301` in first hit, then we need a second hit following above codes
```java
         String loc = res.getHeader('Location'); // get location of the redirect
        System.debug(loc); 
         req = new HttpRequest(); 
         req.setEndpoint(loc+'/?token=xxxxxxxxxx');
         req.setMethod('GET');
         req.setHeader('Content-Type', 'application/json');
         req.setHeader('Accept','application/json');
         res = h.send(req);
         System.debug(res.getBody());
    }
}
```
* To parse json return body we first map the results into string: list(objects) format. If the end point is like 
```java
{
    "emails": [
        {
            "email": "amirxxxx@gmail.com", 
            "verified": false, 
            "primary": true
        }
    ], 
    "id": "2355xxxxxxxx", 
    "name": "sfu3 xxxx", 
    "first_name": "sfuxxxx", 
    "last_name": "Txxxxx", 
    "is_public": false, 
    "image_id": null
}
```
* Then the parsing format is like 
```java
 Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res.getBody()); 
 List<Object> positions = (List<Object>) m.get('emails');
 for (Object item : positions) {
           Map<String, Object> i = (Map<String, Object>)item;
           System.debug(i.get('email')); //which returns amirxxxx@gmail.com
        }
```


