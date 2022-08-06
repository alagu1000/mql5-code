#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      if(PositionsTotal() < 1)
      {
         trade.Buy(0.01, NULL,Ask,0,(Ask+150*_Point),NULL);
      }
   
      double mySARArray[];
      
      int SARDefinition = iSAR(_Symbol, _Period, 0.02, 0.2);
      
      ArraySetAsSeries(mySARArray, true);
      
      CopyBuffer(SARDefinition, 0, 0, 3, mySARArray);
      
      double SARValue = NormalizeDouble(mySARArray[0], 5);
      
      CheckSARBuyTrailingStop(Ask, SARValue);
  }
 
void CheckSARBuyTrailingStop(double Ask, double SARValue)
{
   for (int i=PositionsTotal()-1; i>=0; i--)
   {
      string symbol = PositionGetSymbol(i);
      
      if(_Symbol == symbol)
      {
         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
         
         double CurrentStopLoss = PositionGetDouble(POSITION_SL);
         
         if((CurrentStopLoss < SARValue) || (CurrentStopLoss == 0))
         {
            trade.PositionModify(PositionTicket,SARValue,0);
            
         }
      }
   }
}

