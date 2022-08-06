#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Equity = AccountInfoDouble(ACCOUNT_EQUITY);
      
      double Balance = AccountInfoDouble(ACCOUNT_BALANCE);
      
      double PositionSize =NormalizeDouble(Equity/10000,2);
      
      if(Equity >= Balance)
      {
         if(PositionsTotal() == 0)
         {
            trade.Buy(PositionSize, NULL,Ask,(Ask-50*_Point),(Ask+100*_Point),NULL);
         }
      }
      
      Comment
            ("Balance : ", Balance,"\n",
             "Equity : ", Equity,"\n",
             "Position Size : ", PositionSize
             );
  }

