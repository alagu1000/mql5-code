#include<Trade/Trade.mqh>
CTrade trade;

input double UpperLimit = 10;

input double LowerLimit = 0;

double Ask = 0;

void OnTick()
  {
      Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      if(PositionsTotal() == 0)
      {
         if(PriceIsInRange() == true)
         {
            trade.Buy(0.01, NULL, Ask, (Ask-150*_Point),(Ask+100*_Point),NULL);
         }
         Comment
              (
               "Upper Limit : ", UpperLimit,"\n",
               "Lower Limit : ", LowerLimit,"\n",
               "Ask Price : ", Ask, "\n",
               "Price is within Range : ", PriceIsInRange()
              );
      }
  }
  
bool PriceIsInRange()
{
   bool ReturnValue = false;
   
   if(Ask < UpperLimit)
   if(Ask > LowerLimit)
   {
      ReturnValue = true;
   }
   return ReturnValue;
}