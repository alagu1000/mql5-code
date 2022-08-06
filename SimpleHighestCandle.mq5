
void OnTick()
  {
      MqlRates PriceInformation[];
      
      ArraySetAsSeries(PriceInformation, true);
      
      int data = CopyRates(_Symbol, _Period, 0, 100, PriceInformation);
      
      int HighestCandle;
      
      double High[];
      
      ArraySetAsSeries(High, true);
      
      CopyHigh(_Symbol, _Period, 0, 100, High);
      
      HighestCandle = ArrayMaximum(High, 0, 100);
      
      ObjectCreate(_Symbol, "Line1", OBJ_HLINE, 0, 0, PriceInformation[HighestCandle].high);
      
      ObjectSetInteger(0, "Line1", OBJPROP_ZORDER, clrMagenta);
      
      ObjectSetInteger(0, "Line1", OBJPROP_WIDTH, 3);
      
      ObjectMove(_Symbol, "Line1", 0, 0, PriceInformation[HighestCandle].high);
      
      Comment("Highest Candle: ", HighestCandle, "HighestPrice: ", (PriceInformation[HighestCandle].high),_Digits);
   
  }

