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
      Print("avg:",AverageTrueRangeValue);
      Print("old:",OldValue);
      Print(AverageTrueRangeValue > OldValue);
      if(AverageTrueRangeValue > OldValue)
      {
         signal = "buy";
      }
      else if(AverageTrueRangeValue < OldValue)
      {
         signal = "sell";
      }
      
      if(signal == "buy" && PositionsTotal() < 1)
      {
         trade.Buy(0.10, NULL, Ask, (Ask-200*_Point),(Ask+150*_Point), "Buy");
         OldValue = AverageTrueRangeValue;
      }
      else if(signal == "sell" && PositionsTotal() < 1)
      {
         trade.Sell(0.10, NULL, Bid, (Bid+200*_Point),(Bid-150*_Point), "Buy");
         OldValue = AverageTrueRangeValue;
      }
      
      CalculatedStopPointValue = CheckATRTrailingStop(AverageTrueRangeValue);
      
      Comment("The signa is : ", signal, "\n", "AverageTrueRangeValue : ", AverageTrueRangeValue, "\n", "CalculatedStopPointValue : ", CalculatedStopPointValue, "\n" );
}

int CheckATRTrailingStop(double AverageTrueRangeValue)
{
   double CalculatedStopPointValue = BasicStopPointValue +(AverageTrueRangeValue * 100000);
   
   double CalculatedBuyStopLossPrice = Ask-CalculatedStopPointValue*_Point;
   
   double CalculatedSellStopLossPrice = Bid+CalculatedStopPointValue*_Point;
   
   for(int i = PositionsTotal()-1; i>=0; i--)
   {
      string symbol = PositionGetSymbol(i);
      
      if(_Symbol == symbol)
      {
         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
         
         double CurrentStopLoss = PositionGetDouble(POSITION_SL);
         
         if(CurrentStopLoss < CalculatedBuyStopLossPrice)
         {
            trade.PositionModify(PositionTicket, CalculatedBuyStopLossPrice, 0);
         }
         
         else if((CurrentStopLoss > CalculatedSellStopLossPrice)||(CurrentStopLoss ==0))
         {
            trade.PositionModify(PositionTicket, CalculatedSellStopLossPrice, 0);
         }
         
      }
   }
   return CalculatedStopPointValue;
}