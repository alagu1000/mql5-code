#include<Trade/Trade.mqh>
CTrade trade;
void OnTick()
  {
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
      
      if(PositionsTotal() ==0)
      trade.Buy(0.10, _Symbol, Ask, (Ask-1000*_Point), (Ask+500*_Point),"Buy");
      
      ChangePositionSize(Ask);
   
  }

void ChangePositionSize(double Ask)
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
         
         if(PositionDirection == POSITION_TYPE_BUY)
        
            if(Balance < (Equity + 10 * _Point))
            {
               trade.PositionClosePartial(PositionTicket,0.01,-1);
            }
         
      }
   }
}