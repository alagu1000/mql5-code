
void OnTick()
  {
      datetime LocalTime = TimeLocal();
      
      string HoursAndMinutes = TimeToString(LocalTime,TIME_MINUTES);
      
      string YearAndDate = TimeToString(LocalTime,TIME_DATE);
      
      MqlDateTime DateTimeStructure;
      
      TimeToStruct(LocalTime,DateTimeStructure);
      
      int DayOfTheWeek = DateTimeStructure.day_of_week;
      
      string WeekDay = "";
      
      if(DayOfTheWeek == 1) WeekDay = "Monday";
      if(DayOfTheWeek == 2) WeekDay = "Tuesday";
      if(DayOfTheWeek == 3) WeekDay = "Wednesday";
      if(DayOfTheWeek == 4) WeekDay = "Thursday";
      if(DayOfTheWeek == 5) WeekDay = "Friday";
      if(DayOfTheWeek == 6) WeekDay = "Saturday";
      if(DayOfTheWeek == 0) WeekDay = "Sunday";
      
      Comment("The date is ", YearAndDate,"\n",
               "Today is ", WeekDay, "\n",
               "The time is ",HoursAndMinutes);
   
  }

