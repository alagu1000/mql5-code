
void OnTick()
  {
      int HighestCandle, LowestCandle;
      
      double High[], Low[];
      
      ArraySetAsSeries(High, true);
      
      ArraySetAsSeries(Low, true);
      
      CopyHigh(_Symbol, _Period, 0, 100, High);
      
      CopyLow(_Symbol, _Period, 0, 100, Low);
      
      HighestCandle = ArrayMaximum(High, 0, 100);
      
      LowestCandle = ArrayMinimum(Low, 0, 100);
      
      MqlRates PriceInformation[];
      
      ArraySetAsSeries(PriceInformation, true);
      
      int Data = CopyRates(_Symbol, _Period, 0, Bars(_Symbol, _Period), PriceInformation);
      
      ObjectDelete(_Symbol, "Fibonacci");
      
      ObjectCreate
      (
         _Symbol,
         "Fibonacci",
         OBJ_FIBO,
         0,
         PriceInformation[100].time,
         PriceInformation[HighestCandle].high,
         PriceInformation[0].time,
         PriceInformation[LowestCandle].low
      );
      
      datetime DateTime0 = ObjectGetInteger(0,"Fibonacci", OBJPROP_TIME, 0);
      double PriceLevel100 = ObjectGetDouble(0,"Fibonacci", OBJPROP_PRICE, 0);
      datetime DateTime1 = ObjectGetInteger(0,"Fibonacci", OBJPROP_TIME, 1);
      double PriceLevel0 = ObjectGetDouble(0,"Fibonacci", OBJPROP_PRICE, 1);
      
      double PriceLevel50 = ((PriceLevel100+PriceLevel0)*0.5);
      
      Comment  
      (
            "DateTime0: ", DateTime0,"\n",
            "DateTime1: ", DateTime1,"\n",
            "PriceLevel 0: ", PriceLevel0,"\n",
            "PriceLevel 50: ", PriceLevel50,"\n",
            "PriceLevel 100: ", PriceLevel100
      );
      
   
  }

