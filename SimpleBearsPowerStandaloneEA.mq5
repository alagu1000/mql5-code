#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);   
      
      string signal = "";
      
      MqlRates PriceInformation[];
      
      ArraySetAsSeries(PriceInformation, true);
      
      int Data = CopyRates(_Symbol, _Period, 0, 3, PriceInformation);
      
      double MyPriceArray[];
      
      ArraySetAsSeries(MyPriceArray, true);
      
      int BearsPowerDefinition = iBearsPower(_Symbol, _Period, 13);
      
      CopyBuffer(BearsPowerDefinition, 0, 0, 3, MyPriceArray);
      
      double BearsPowerValue = MyPriceArray[0];
      
      if(BearsPowerValue > 0)
      {
         signal = "buy";
      }
      else if (BearsPowerValue <0)
      {
         signal = "sell";
      }
      
      if(signal == "sell" && PositionsTotal() < 1)
     {
         trade.Sell(0.10, NULL, Bid, 0, (Bid-150*_Point), "Sell");
     }
     else if(signal == "buy" && PositionsTotal() < 1)
     {
         trade.Buy(0.10, NULL, Ask, 0, (Ask+150*_Point), "Buy");
     }
     
     Comment("The Current Signal is : ", signal);
  }