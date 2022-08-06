#include<Trade/Trade.mqh>
CTrade trade;
void OnTick()
  {
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
      
      if(PositionsTotal() < 10)
      trade.Buy(0.10, _Symbol, Ask, 0, (Ask+300*_Point),"Buy");
      
      if(PositionsTotal() ==10)
      {
         CloseAllBuyPositions();
      }
  }

void CloseAllBuyPositions()
{
   for(int i = PositionsTotal()-1; i>=0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      
      long PositionDirection = PositionGetInteger(POSITION_TYPE);
      
      if(PositionDirection == POSITION_TYPE_BUY)
      {
         trade.PositionClose(ticket);
      }
   }
}