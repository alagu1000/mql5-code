#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
      
      MqlRates PriceInfo[];
      
      ArraySetAsSeries(PriceInfo, true);
      
      int PriceData = CopyRates(_Symbol, _Period, 0, 3, PriceInfo);
      
      string signal = "";
      
      double myPriceArray[];
      
      int CCIDefinition = iCCI(_Symbol, _Period, 14, PRICE_CLOSE);
      
      ArraySetAsSeries(myPriceArray, true);
      
      CopyBuffer(CCIDefinition, 0, 0, 3, myPriceArray);
      
      double CCIValue = (myPriceArray[0]);
      
      if(CCIValue > 100 )
      {
         signal = "sell";
      }
      else if(CCIValue < -100)
      {
         signal = "buy";
      }
      
       if(signal == "sell" && PositionsTotal() < 1)
      {
         trade.Sell(0.01, NULL,Bid,(Bid+1000*_Point),(Bid-150*_Point),NULL);
      }
      else if(signal == "buy" && PositionsTotal() < 1)
      {
         trade.Buy(0.01, NULL,Ask,(Ask-1000*_Point),(Ask+150*_Point),NULL);
      }
      Comment("The signal is now : ", signal);
   
  }

