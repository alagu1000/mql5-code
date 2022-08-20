#include<Trade/Trade.mqh>
CTrade trade;



void OnTick()
  {
      double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID),_Digits);
      
      if(PositionsTotal() < 1)
      {
         trade.Buy(0.10, NULL, Ask, (Ask-200*_Point),(Ask+150*_Point), "Buy");
         trade.Sell(0.10, NULL, Bid, (Bid+200*_Point),(Bid-150*_Point), "Buy");
      }
      GetCloseTime();
      
}

void GetCloseTime()
{
   uint TotalNumberOfDeals = HistoryDealsTotal();
   ulong TicketNumber = 0;
   long OrderType, DealEntry;
   double OrderProfit = 0;
   string MySymbol = "";
   string PositionDirection = "";
   string MyResult ="";
   int DealTime = 0;
   string ClosingTime = "";
   
   HistorySelect(0, TimeCurrent());
   
   for(uint i = 0; i < TotalNumberOfDeals; i++)
   {
      if((TicketNumber = HistoryDealGetTicket(i)) > 0)
      {
         OrderProfit = HistoryDealGetDouble(TicketNumber, DEAL_PROFIT);
         
         OrderType = HistoryDealGetInteger(TicketNumber, DEAL_TYPE);
         
         MySymbol = HistoryDealGetString(TicketNumber, DEAL_SYMBOL);
         
         DealEntry = HistoryDealGetInteger(TicketNumber, DEAL_ENTRY);
         
         DealTime = HistoryDealGetInteger(TicketNumber, DEAL_TIME);
         
         ClosingTime = TimeToString(DealTime, TIME_DATE | TIME_SECONDS);
         
         if(MySymbol == _Symbol)
         {
            if(OrderType == ORDER_TYPE_BUY || OrderType == ORDER_TYPE_SELL)
            {
               if(DealEntry == 1)
               {
                  MyResult = "Profit : "+OrderProfit+"Ticket : "+TicketNumber+"Closing Time :"+ClosingTime;
                  
                  Print(MyResult);
               }
            }
         
         }
      }
   }
   
}