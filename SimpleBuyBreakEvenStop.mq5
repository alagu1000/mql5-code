#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
       double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
       
       if(PositionsTotal() == 0)
       {
         trade.Buy(0.01, NULL,Ask,(Ask-300*_Point),(Ask+300*_Point),NULL);
       }
       
       CheckBuyBreakEvenStop(Ask);   
  }

void CheckBuyBreakEvenStop(double Ask)
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
         if(PositionType == POSITION_TYPE_BUY)
         {
            if(PositionStopLoss < PositionBuyPrice)
            {
               if(Ask > (PositionBuyPrice + 30 *_Point))
               {
                  trade.PositionModify(PositionTicket, PositionBuyPrice + 4*_Point, PositionTakeProfit);
               }
            }
         }
      }
      
      
   }
}

