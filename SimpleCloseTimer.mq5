#include<Trade/Trade.mqh>
CTrade trade;
void OnTick()
  {
      double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
      
       if(PositionsTotal() == 0)
       {
         trade.Buy(0.01, NULL,Ask,(Ask-1000*_Point),(Ask+150*_Point),NULL);
         trade.Sell(0.01, NULL,Bid,(Bid+1000*_Point),(Bid-150*_Point),NULL);
       }
      CheckCloseTimer();
  }

void CheckCloseTimer()
{
   for(int i=PositionsTotal()-1; i>=0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      
      datetime PositionOpenTime = PositionGetInteger(POSITION_TIME);
      
      MqlDateTime MyOpenTime;
      
      int OpeningHour = MyOpenTime.hour;
      
      datetime LocalTime = TimeLocal();
      
      MqlDateTime MyLocalTime;
      
      TimeToStruct(LocalTime, MyLocalTime);
      
      int CurrentHour = MyLocalTime.hour;
      
      int Difference = CurrentHour - OpeningHour;
      
      Print("### Position Ticket : ", ticket);
      Print("### Position Open Time : ", PositionOpenTime);
      Print("### Local Time : ", LocalTime);
      Print("### Difference : ", Difference);
      
      double PositionProfit = PositionGetDouble(POSITION_PROFIT);
      
      if(Difference > 0)
      {
         if(PositionProfit < 0)
         {
            trade.PositionClose(ticket);
         }
      }
   }      
}