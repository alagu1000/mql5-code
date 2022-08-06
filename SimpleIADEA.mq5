#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
      
      string signal = "";
      
      double myPriceArray[], myMovingAverageArray[];
      
      ArraySetAsSeries(myPriceArray, true);
      
      ArraySetAsSeries(myMovingAverageArray, true);
      
      int myMovingAverageArrayDefinition = iMA(_Symbol, _Period, 20, 0, MODE_SMA, PRICE_CLOSE);
      
      ArraySetAsSeries(myMovingAverageArray, true);
      
      CopyBuffer(myMovingAverageArrayDefinition, 0, 0, 3, myMovingAverageArray);
      
      double myMovingAverageValue = myMovingAverageArray[0];
      
      int IADDefinition = iAD(_Symbol, _Period, VOLUME_TICK);
      
      CopyBuffer(IADDefinition, 0, 0, 11, myPriceArray);
      
      double IADValue = myPriceArray[0];
      
      double LastIADValue = (myPriceArray[10]);
      
      if(Ask > myMovingAverageValue)
      {
         if(IADValue > LastIADValue)
         {
            signal = "buy";
         }
      }
      else if (Bid < myMovingAverageValue)
      {
         if(IADValue < LastIADValue)
         {
            signal = "sell";
         }
      }
      
      if(signal == "sell" && PositionsTotal() < 1)
      {
         trade.Sell(0.01, NULL,Bid,(Bid+1000*_Point),(Bid-150*_Point),NULL);
      }
      else if(signal == "buy" && PositionsTotal() < 1)
      {
         trade.Buy(0.01, NULL,Ask,(Ask-1000*_Point),(Ask+150*_Point),NULL);
      }
      
      Comment("The Current Signal is :", signal);
  }

