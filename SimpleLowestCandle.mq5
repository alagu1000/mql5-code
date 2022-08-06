
void OnTick()
  {
      MqlRates PriceInformation[];
      
      ArraySetAsSeries(PriceInformation, true);
      
      int data = CopyRates(_Symbol, _Period, 0, 100, PriceInformation);
      
      int LowestCandle;
      
      double Low[];
      
      ArraySetAsSeries(Low, true);
      
      CopyLow(_Symbol, _Period, 0, 100, Low);
      
      LowestCandle = ArrayMinimum(Low, 0, 100);
      
      ObjectCreate(_Symbol, "Line1", OBJ_HLINE, 0, 0, PriceInformation[LowestCandle].low);
      
      ObjectSetInteger(0, "Line1", OBJPROP_ZORDER, clrMagenta);
      
      ObjectSetInteger(0, "Line1", OBJPROP_WIDTH, 3);
      
      ObjectMove(_Symbol, "Line1", 0, 0, PriceInformation[LowestCandle].low);
      
      Comment("Lowest Candle: ", LowestCandle, "LowestPrice: ", (PriceInformation[LowestCandle].low),_Digits);
   
  }

