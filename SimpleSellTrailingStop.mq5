#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      double Bid =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
      
      if(PositionsTotal() < 1)
      {
         trade.Sell(0.01, NULL,Bid,0,(Bid-150*_Point),NULL);
      }
   
      double mySARArray[];
      
      int SARDefinition = iSAR(_Symbol, _Period, 0.02, 0.2);
      
      ArraySetAsSeries(mySARArray, true);
      
      CopyBuffer(SARDefinition, 0, 0, 3, mySARArray);
      
      double SARValue = NormalizeDouble(mySARArray[0], 5);
      
      CheckSARSellTrailingStop(Bid, SARValue);
  }
 
void CheckSARBuyTrailingStop(double Bid, double SARValue)
{
   for (int i=PositionsTotal()-1; i>=0; i--)
   {
      string symbol = PositionGetSymbol(i);
      
      if(_Symbol == symbol)
      {
         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
         
         double CurrentStopLoss = PositionGetDouble(POSITION_SL);
         
         if(CurrentStopLoss > SARValue)
         {
            trade.PositionModify(PositionTicket,SARValue,0);
            
         }
      }
   }
}

