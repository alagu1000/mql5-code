#include<Trade/Trade.mqh>
CTrade trade;

int BasicStopPointValue = 100;

int CalculatedStopPointValue;

double Ask, Bid;

void OnTick()
  {
      string signal = "";
      
      Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
      
      double PriceArray[];
      
      int AvrageTrueRangeDefinition = iATR(_Symbol, _Period, 14);
      
      ArraySetAsSeries(PriceArray, true);
      
      CopyBuffer(AvrageTrueRangeDefinition, 0, 0, 3, PriceArray);
      
      double AverageTrueRangeValue = NormalizeDouble(PriceArray[0], 5);
      
      static double OldValue;
      
      if(AverageTrueRangeValue < OldValue)
      {
         signal = "sell";
      }
      
      if(signal == "sell" && PositionsTotal() < 1)
      {
         trade.Sell(0.10, NULL, Bid, (Bid+200*_Point),(Bid-150*_Point), "Buy");
      }
      
      CalculatedStopPointValue = CheckATRSellTrailingStop(AverageTrueRangeValue);
      
      Comment("The signa is : ", signal, "\n", "AverageTrueRangeValue : ", AverageTrueRangeValue, "\n", "CalculatedStopPointValue : ", CalculatedStopPointValue, "\n" );
      
      OldValue = AverageTrueRangeValue;
}

int CheckATRSellTrailingStop(double AverageTrueRangeValue)
{
   CalculatedStopPointValue = BasicStopPointValue +(AverageTrueRangeValue * 100000);
   
   double CalculatedStopLossPrice = Bid+CalculatedStopPointValue*_Point;
   
   for(int i = PositionsTotal()-1; i>=0; i--)
   {
      string symbol = PositionGetSymbol(i);
      
      if(_Symbol == symbol)
      {
         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
         
         double CurrentStopLoss = PositionGetDouble(POSITION_SL);
         
         if((CurrentStopLoss > CalculatedStopLossPrice)||(CurrentStopLoss ==0))
         {
            trade.PositionModify(PositionTicket, CalculatedStopLossPrice, 0);
         }
         
      }
   }
   return CalculatedStopPointValue;
}