#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
      
      double RSIArray[];
      
      ArraySetAsSeries(RSIArray, true);
      
      int RSIDefinition = iRSI(_Symbol, _Period, 14, PRICE_CLOSE);
      
      CopyBuffer(RSIDefinition, 0, 0, 3, RSIArray);
      
      double RSIValue = NormalizeDouble(RSIArray[0], 2);
      
      if((PositionsTotal()==0) && (RSIValue < 30 ))
      {
         trade.Buy(0.10, NULL, Ask, (Ask - 150 * _Point), 0, "Buy");
      }
      
      CheckRSIBuyStop(RSIValue);
      
      Comment("RSI Value : ", RSIValue);
   
  }

void CheckRSIBuyStop(double RSIValue)
{
   for (int i =PositionsTotal() -1; i >= 0; i--)
   {
      string PositionSymbol = PositionGetSymbol(i);
      
      ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
      
      long PositionType = PositionGetInteger(POSITION_TYPE);
      
      if(PositionType == POSITION_TYPE_BUY)
      {
         if(RSIValue > 70)
         {
            trade.PositionClose(PositionTicket);
         }
      }
   }

}
