#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);   
      
     MqlRates PriceInfo[];
     
     ArraySetAsSeries(PriceInfo, true);
     
     int PriceData = CopyRates(_Symbol, _Period, 0, 3, PriceInfo);
     
     string signal = "";
     
     double myEaArray[];
     
     int MovingAverageDefinition = iDEMA(_Symbol, _Period, 14, 0, PRICE_CLOSE);
     
     ArraySetAsSeries(myEaArray, true);
     
     CopyBuffer(MovingAverageDefinition, 0, 0, 3, myEaArray);
     
     double myMovingAverageValue = myEaArray[1];
     
     if(myMovingAverageValue > PriceInfo[1].close)
     {
         signal = "sell";
     }
     else if(myMovingAverageValue < PriceInfo[1].close)
     {
         signal = "buy";
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