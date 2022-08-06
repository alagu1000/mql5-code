#include<Trade/Trade.mqh>
CTrade trade;

input string StartTradingTime = "12:30";
      
input string StopTradingTime = "13:00";
      
string CurrentTime;
      
bool TradingIsAllowed = false;

void OnTick()
  {
      double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      datetime time = TimeLocal();
      
      CurrentTime = TimeToString(time, TIME_MINUTES);
      
      if(CheckTradingTime() == true)
      {
         if(PositionsTotal() == 0)
         {
            trade.Buy(0.01,_Symbol,Ask,0,(Ask+100 * _Point),"Buy");
         }
      }    
      Comment
            (
               "TradingIsAllwed: ", TradingIsAllowed, "\n",
               "Current Time: ", CurrentTime,"\n",
               "Start Trading Time: ", StartTradingTime, "\n",
               "Stop Trading Time: ", StopTradingTime
            );
  }

bool CheckTradingTime()
{
   if(StringSubstr(CurrentTime,0,5) == StartTradingTime)
   {
      TradingIsAllowed = true;
   }
   else if(StringSubstr(CurrentTime,0,5) == StopTradingTime)
   {
      TradingIsAllowed = false;
   }
   return TradingIsAllowed;
}
