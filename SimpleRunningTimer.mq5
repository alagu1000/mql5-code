datetime CurrentTime;
datetime StartTime;
datetime PassedTime;

void OnTick()
  {
      if(StartTime == 0)
      {
         StartTime = TimeLocal();
      }  
      
      CurrentTime = TimeLocal();
      
      PassedTime = CurrentTime - StartTime;
      
      MqlDateTime DateTimeStructure;
      
      TimeToStruct(PassedTime, DateTimeStructure);
      
      int PassedTimeInHours = DateTimeStructure.hour;
      
      int PassedTimeInMinutes = DateTimeStructure.min;
      
      int PassedTimeInSeconds = DateTimeStructure.sec;
      
      Comment
            (
               "Start Time : ", StartTime, "\n",
               "Current Time : ", CurrentTime, "\n",
               "Passed Time in Hours : ", PassedTimeInHours, "\n",
               "Passed Time in Minutes :", PassedTimeInMinutes, "\n",
               "Passed Time in Seconds : ", PassedTimeInSeconds, "\n"
            );
   
  }

