Global class attendeesbatchsche implements Schedulable {
 global void execute(SchedulableContext SC)
  {
    // create a loader class and instantiate it
    // define query in loader class
    AttendeesBatchLoader myLoader = new AttendeesBatchLoader();
    // set the query string for the SOQL query
    myLoader.query = 'select Id from Case';
    
    ////// 
    integer myBatchSize = 1;
    ID batchprocessid = Database.executeBatch(myLoader, myBatchSize);
    /// return the user to the current page 
  } 
}