#include<Trade/Trade.mqh>
CTrade trade;
void OnTick()
  {
      double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
      
      if(PositionsTotal() ==0)
      trade.Sell(0.10, _Symbol, Bid, (Bid+1000*_Point), (Bid-500*_Point),"Sell");
      
      ChangePositionSize(Bid);
   
  }

void ChangePositionSize(double Bid)
{
   double Balance = AccountInfoDouble(ACCOUNT_BALANCE);
   
   double Equity = AccountInfoDouble(ACCOUNT_EQUITY);
   
   for(int i=PositionsTotal()-1; i>=0; i--)
   {
      string symbol = PositionGetSymbol(i);
      
      if(_Symbol == symbol)
      {
         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
         
         long PositionDirection = PositionGetInteger(POSITION_TYPE);
         
         if(PositionDirection == POSITION_TYPE_SELL)
        
            if(Balance < (Equity + 10 * _Point))
            {
               trade.PositionClosePartial(PositionTicket,0.01,-1);
            }
         
      }
   }
}