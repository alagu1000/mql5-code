#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      string entry = "";
      
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);   
      
      double myMovingAverage950[], myMovingAverage1000[];
      
      int MovingAverageDefinition1 = iMA(_Symbol, _Period, 950, 0, MODE_EMA, PRICE_CLOSE);
      
      int MovingAverageDefinition2 = iMA(_Symbol, _Period, 1000, 0, MODE_EMA, PRICE_CLOSE);
      
      ArraySetAsSeries(myMovingAverage950, true);
      
      ArraySetAsSeries(myMovingAverage1000, true);
      
      CopyBuffer(MovingAverageDefinition1, 0, 0, 3, myMovingAverage950);
      
      CopyBuffer(MovingAverageDefinition2, 0, 0, 3, myMovingAverage1000);
      
      if(myMovingAverage950[0] > myMovingAverage1000[0])
      {
         entry = "buy";
      }
      else if(myMovingAverage950[0] < myMovingAverage1000[0])
      {
         entry = "sell";
      }
      
      if(entry == "buy" && PositionsTotal() < 1)
      {
         trade.Buy(0.10, NULL, Ask, (Ask-50*_Point), (Ask+50*_Point), "Sell");
      }
      
      else if(entry == "sell" && PositionsTotal() < 1)
      {
         trade.Sell(0.10, NULL, Bid, (Bid+50*_Point), (Bid-50*_Point), "Sell");
      }
   
  }

