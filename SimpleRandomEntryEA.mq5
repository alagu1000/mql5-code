#include<Trade/Trade.mqh>
CTrade trade;

input int MassTest =1;
void OnTick()
  {
      double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
      
      string signal = "";
      
      MathSrand(GetTickCount());
      
      double  RandomNumber = MathRand() % 2;
      
      if (RandomNumber == 0) signal = "buy";
      
      if (RandomNumber == 1) signal = "sell";
      
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