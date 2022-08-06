
void OnTick()
  {
      int HighestCandle, LowestCandle;
      
      double High[], Low[];
      
      ArraySetAsSeries(High, true);
      
      ArraySetAsSeries(Low, true);
      
      CopyHigh(_Symbol, _Period, 0, 30, High);
      
      CopyLow(_Symbol, _Period, 0, 30, Low);
      
      HighestCandle = ArrayMaximum(High, 0, 30);
      
      LowestCandle = ArrayMinimum(Low, 0, 30);
      
      MqlRates PriceInformation[];
      
      ArraySetAsSeries(PriceInformation, true);
      
      int Data = CopyRates(_Symbol, _Period, 0, Bars(_Symbol, _Period), PriceInformation);
      
      ObjectDelete(_Symbol, "Rectangle");
      
      ObjectCreate
                 (_Symbol,
                  "Rectangle",
                  OBJ_RECTANGLE,
                  0,
                  PriceInformation[30].time,
                  PriceInformation[HighestCandle].high,
                  PriceInformation[0].time,
                  PriceInformation[LowestCandle].low
               );
      
      ObjectSetInteger(0, "Rectangle", OBJPROP_COLOR, clrBlue);
      
      ObjectSetInteger(0, "Rectangle", OBJPROP_FILL, clrBlue);
      
      
  }

