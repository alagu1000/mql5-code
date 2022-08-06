#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      double Bid =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
      
      double Equity = AccountInfoDouble(ACCOUNT_EQUITY);
      
      double Balance = AccountInfoDouble(ACCOUNT_BALANCE);
      
      double PositionSize =NormalizeDouble(Equity/10000,2);
      
      if(Equity >= Balance)
      {
         if(PositionsTotal() == 0)
         {
            trade.Sell(PositionSize, NULL,Bid,(Bid+50*_Point),(Bid-100*_Point),NULL);
         }
      }
      
      Comment
            ("Balance : ", Balance,"\n",
             "Equity : ", Equity,"\n",
             "Position Size : ", PositionSize
             );
  }

