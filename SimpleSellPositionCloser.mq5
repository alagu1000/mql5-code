#include<Trade/Trade.mqh>
CTrade trade;
void OnTick()
  {
      double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
      
      if(PositionsTotal() < 10)
      trade.Sell(0.10, _Symbol, Bid, 0, (Bid-300*_Point),"Sell");
      
      if(PositionsTotal() ==10)
      {
         CloseAllSellPositions();
      }
  }

void CloseAllSellPositions()
{
   for(int i = PositionsTotal()-1; i>=0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      
      long PositionDirection = PositionGetInteger(POSITION_TYPE);
      
      if(PositionDirection == POSITION_TYPE_SELL)
      {
         trade.PositionClose(ticket);
      }
   }
}