#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
       double Bid =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
       
       if(PositionsTotal() == 0)
       {
         trade.Sell(0.01, NULL,Bid,(Bid+300*_Point),(Bid-300*_Point),NULL);
       }
       
       CheckCellBreakEvenStop(Bid);   
  }

void CheckCellBreakEvenStop(double Bid)
{
   for(int i=PositionsTotal()-1; i>=0; i--)
   {
      ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
      
      double PositionBuyPrice = PositionGetDouble(POSITION_PRICE_OPEN);
      
      double PositionStopLoss = PositionGetDouble(POSITION_SL);
      
      double PositionTakeProfit = PositionGetDouble(POSITION_TP);
      
      long PositionType = PositionGetInteger(POSITION_TYPE);
      
      string symbol = PositionGetSymbol(i);
      
      if(_Symbol == symbol)
      {
         if(PositionType == POSITION_TYPE_SELL)
         {
            if(PositionStopLoss > PositionBuyPrice)
            {
               if(Bid < (PositionBuyPrice - 30 *_Point))
               {
                  trade.PositionModify(PositionTicket, PositionBuyPrice - 4*_Point, PositionTakeProfit);
               }
            }
         }
      }
      
      
   }
}

