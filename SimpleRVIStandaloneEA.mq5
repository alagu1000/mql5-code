#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);   
      
      string signal = "";
      
      double MyPriceArray0[];
       double MyPriceArray1[];
      
      ArraySetAsSeries(MyPriceArray0, true);
      ArraySetAsSeries(MyPriceArray1, true);
      
      int RVIDefinition = iRVI(_Symbol, _Period, 10);
      
      CopyBuffer(RVIDefinition, 0, 0, 3, MyPriceArray0);
      CopyBuffer(RVIDefinition, 1, 0, 3, MyPriceArray1);
      
      double RVIValue0 = NormalizeDouble(MyPriceArray0[0], 3);
      double RVIValue1 = NormalizeDouble(MyPriceArray1[0], 3);
      
      if(RVIValue0 < RVIValue1)
      {
         if((RVIValue0 < 0)&&(RVIValue1 < 0 ))
         {
            signal = "buy";
         }
      }
      else if(RVIValue0 > RVIValue1)
      {
         if((RVIValue0 > 0)&&(RVIValue1 > 0 ))
         {
            signal = "sell";
         }
      }
      
       if(signal == "buy" && PositionsTotal() < 1)
         {
            trade.Buy(0.10, NULL, Ask, 0, (Ask+150*_Point), "Sell");
         }
         
         else if(signal == "sell" && PositionsTotal() < 1)
         {
            trade.Sell(0.10, NULL, Bid, 0, (Bid-150*_Point), "Sell");
         }
         
         Comment("Entry Signal : ", signal);
      
      
      
  }