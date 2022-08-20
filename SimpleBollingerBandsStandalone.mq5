#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      string entry = "";
      
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);   
      
      MqlRates PriceInfo[];
      
      ArraySetAsSeries(PriceInfo, true);
      
      int PriceData = CopyRates(_Symbol, _Period, 0, 3, PriceInfo);
      
      double UpperBandArray[], LowerBandArray[];
      
      ArraySetAsSeries(UpperBandArray, true);
      
      ArraySetAsSeries(LowerBandArray, true);
      
      int BollingerBandsDefinition = iBands(_Symbol, _Period, 20, 0, 2, PRICE_CLOSE);
      
      CopyBuffer(BollingerBandsDefinition, 1, 0, 3, UpperBandArray);
      CopyBuffer(BollingerBandsDefinition, 2, 0, 3, LowerBandArray);
      
      double myUpperBandValue = UpperBandArray[0];
      double myLowerBandValue = LowerBandArray[0];
      
      double myLastUpperBandValue = UpperBandArray[1];
      double myLastLowerBandValue = LowerBandArray[1];
      
      if(
            (PriceInfo[0].close > myLowerBandValue)
          &&(PriceInfo[1].close < myLastLowerBandValue)      
         )
         {
            entry = "buy";
         }
         else if(
            (PriceInfo[0].close < myUpperBandValue)
          &&(PriceInfo[1].close > myLastUpperBandValue)      
         )
         {
            entry = "sell";
         }
         
         if(entry == "buy" && PositionsTotal() < 1)
         {
            trade.Buy(0.10, NULL, Ask, (Ask-50*_Point), (Ask+150*_Point), "Sell");
         }
         
         else if(entry == "sell" && PositionsTotal() < 1)
         {
            trade.Sell(0.10, NULL, Bid, (Bid+50*_Point), (Bid-150*_Point), "Sell");
         }
         
         Comment("Entry Signal : ", entry);
  }