#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);   
      
      string signal = "";
      
      MqlRates PriceInformation[];
      
      ArraySetAsSeries(PriceInformation, true);
      
      int Data = CopyRates(_Symbol, _Period, 0, 3, PriceInformation);
      
      double PriceArray[];
      
      int AwesomeOscillatorDefinition = iAO(_Symbol, _Period);
      
      ArraySetAsSeries(PriceArray, true);
      
      CopyBuffer(AwesomeOscillatorDefinition, 0, 0, 3, PriceArray);
      
      double AwesomeOscillatorValue = NormalizeDouble(PriceArray[0],6);
      
      if(AwesomeOscillatorValue > 0)
      {
         signal = "buy";
      }
      else if(AwesomeOscillatorValue < 0)
      {
         signal = "sell";
      }
      
       if(signal == "buy" && PositionsTotal() < 1)
         {
            trade.Buy(0.10, NULL, Ask, 0, (Ask+150*_Point), "Sell");
         }
         
         else if(signal == "sell" && PositionsTotal() < 1)
         {
            trade.Sell(0.10, NULL, Bid, 0, (Bid-150*_Point), "Sell");
         }
         
         Comment("Entry Signal : ", signal);
}      
