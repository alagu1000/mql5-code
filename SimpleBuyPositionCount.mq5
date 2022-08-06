//+------------------------------------------------------------------+
//|                                       SimpleBuyPositionCount.mq5 |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include<Trade/Trade.mqh>
CTrade trade;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
      OpenTestPositions();
      
      Comment("Number of Positions :", CountBuyPositions());
   
  }
//+------------------------------------------------------------------+
int CountBuyPositions()
{
   int NumberOfBuyPositions = 0;
   
   for(int i = PositionsTotal()-1; i>=0; i--)
   {
      string CurrencyPair = PositionGetSymbol(i);
      
      long PositionDirection = PositionGetInteger(POSITION_TYPE);
      
      if(_Symbol == CurrencyPair)
      
      if(PositionDirection == POSITION_TYPE_BUY)
      {
         NumberOfBuyPositions = NumberOfBuyPositions+1;
      }
   }
   return NumberOfBuyPositions;
}  

void OpenTestPositions()
{
   MathSrand(GetTickCount());
   
   double NumberOfTestPositions = MathRand()%10;
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   
   for(int i=0; i < NumberOfTestPositions; i++)
   {
      trade.Buy(0.10, _Symbol, Ask, 0, (Ask+300*_Point),"Buy");
      trade.Sell(0.10, _Symbol, Bid, 0, (Bid-300*_Point),"Sell");
   }
}