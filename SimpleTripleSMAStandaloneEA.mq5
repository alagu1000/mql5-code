#include<Trade/Trade.mqh>
CTrade trade;

void OnTick()
  {
      
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);   
      
      string signal = "";
      
      MqlRates PriceInformation[];
      
      ArraySetAsSeries(PriceInformation, true);
      
      int PriceData = CopyRates(_Symbol, _Period, 0, 3, PriceInformation);
      
      int SMA10Definition = iMA(_Symbol, _Period, 10,  3, MODE_SMA, PRICE_CLOSE);
      
      int SMA50Definition = iMA(_Symbol, _Period, 50, 3, MODE_SMA, PRICE_CLOSE);
      
      int SMA100Definition = iMA(_Symbol, _Period, 100, 3, MODE_SMA, PRICE_CLOSE);
      
      double SMA10Array[], SMA50Array[], SMA100Array[];
      
      ArraySetAsSeries(SMA10Array, true);
      
      ArraySetAsSeries(SMA50Array, true);
      
      ArraySetAsSeries(SMA100Array, true);
      
      CopyBuffer(SMA10Definition, 0, 0, 10, SMA10Array);
      
      CopyBuffer(SMA50Definition, 0, 0, 50, SMA50Array);
      
      CopyBuffer(SMA100Definition, 0, 0, 100, SMA100Array);
      
      if(SMA10Array[0] > SMA50Array[0])
      {
         if(SMA50Array[0] > SMA100Array[0])
         {
            signal = "buy";
         }
      }
      else if(SMA10Array[0] < SMA50Array[0])
      {
         if(SMA50Array[0] < SMA100Array[0])
         {
            signal = "sell";
         }
      }
      
      if(signal == "sell" && PositionsTotal() < 1)
     {
         trade.Sell(0.10, NULL, Bid, 0, (Bid-150*_Point), "Sell");
     }
     else if(signal == "buy" && PositionsTotal() < 1)
     {
         trade.Buy(0.10, NULL, Ask, 0, (Ask+150*_Point), "Buy");
     }
     
     Comment("The Current Signal is : ", signal);
      
      
      
  }    