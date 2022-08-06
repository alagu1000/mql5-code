#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
      
      string signal = "";
      
      double WPRArray[];
      
      int WPRDefinition = iWPR(_Symbol, _Period, 14);
      
      ArraySetAsSeries(WPRArray, true);
      
      CopyBuffer(WPRDefinition, 0, 0, 3, WPRArray);
      
      double WPRValue = NormalizeDouble(WPRArray[0], 2);
      
      if((WPRValue < -80 ) && (WPRValue > -100))
      {
         signal = "buy";
      }
      else if((WPRValue > -20 ) && (WPRValue < 0))
      {
         signal = "sell";
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

