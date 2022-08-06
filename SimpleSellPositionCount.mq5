#include<Trade/Trade.mqh>
CTrade trade;

int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
void OnTick()
  {
      OpenTestPositions();
      Comment("Number of Cell Positions : ",CountSellPositions());
   
  }

int CountSellPositions()
{
   int NumberOfSellPositions = 0;
   
   for (int i=PositionsTotal()-1; i>=0; i--)
   {
      string CurrencyPair = PositionGetSymbol(i);
      
      long PositionDirection = PositionGetInteger(POSITION_TYPE);
      
      if(_Symbol == CurrencyPair)
      {
         if(PositionDirection == POSITION_TYPE_SELL)
         {
            NumberOfSellPositions = NumberOfSellPositions+1;
         }
      }
   }
   return NumberOfSellPositions;
}

void OpenTestPositions()
{
   MathSrand(GetTickCount());
   
   double NumberOfTestPositions = MathRand()% 10;
   
   double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
   double Bid =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
   
   for (int i=0; i< NumberOfTestPositions; i++)
   {
      trade.Buy(0.01, NULL,Ask,(Ask-1000*_Point),(Ask+150*_Point),NULL);
      trade.Sell(0.01, NULL,Bid,(Bid+1000*_Point),(Bid-150*_Point),NULL);
   }
}