#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
      
      string signal = "";
      
      double myIOSMAArray[];
      
      ArraySetAsSeries(myIOSMAArray, true);
      
      int myIOSMAArrayDefinition = iOsMA(_Symbol, _Period, 12, 26, 9, PRICE_CLOSE);
      
      CopyBuffer(myIOSMAArrayDefinition, 0, 0, 3, myIOSMAArray);
      
      double myIOSMAValue = myIOSMAArray[0];
      
      double myLastIOSMAValue = (myIOSMAArray[1]);
      
      if((myIOSMAValue < 0 ) && (myLastIOSMAValue > 0 ))
      {
         signal ="sell";
      }
      else if((myIOSMAValue > 0 ) && (myLastIOSMAValue < 0 ))
      {
         signal ="buy";
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