#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      string signal;
      
      double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
      
      double KArray[];
      double DArray[];
      
      ArraySetAsSeries(KArray, true);
      ArraySetAsSeries(DArray, true);
      
      int StochasticDefinition = iStochastic(_Symbol, _Period, 5, 3, 3, MODE_SMA, STO_LOWHIGH);
      
      CopyBuffer(StochasticDefinition, 0, 0, 3, KArray);
      CopyBuffer(StochasticDefinition, 1, 0, 3, DArray);
      
      double KValue0 = KArray[0];
      double DValue0 = DArray[0];
      
      double KValue1 = KArray[1];
      double DValue1 = DArray[1];
      
      if(KValue0 < 20  && DValue0 < 20)
      {
         if((KValue0 > DValue0) && (KValue1 < DValue1))
         {
            signal = "buy";
         }
      }
      else if(KValue0 > 80  && DValue0 < 80)
      {
         if((KValue0 < DValue0) && (KValue1 > DValue1))
         {
            signal = "sell";
         }
      }
      
       if(signal == "sell" && PositionsTotal() < 1)
      {
         trade.Sell(0.01, NULL,Bid,(Bid+1000*_Point),(Bid-150*_Point),NULL);
      }
      else if(signal == "buy" && PositionsTotal() < 1)
      {
         trade.Buy(0.01, NULL,Ask,(Ask-1000*_Point),(Ask+150*_Point),NULL);
      }
      Comment("The signal is now : ", signal);
   
  }

