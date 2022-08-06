


#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <SourceCode.mqh>
#include<Trade\Trade.mqh>
CTrade trades;
Events event;
double Ask,Bid;
//+------------------------------------------------------------------+
//| input variables in global                                        |
//+------------------------------------------------------------------+
input int      Xco=5;//X Co-ordinate
input int      Yco=20;//Y Co-ordinate
input int      Width=300;
input int      Height=1500;
input int      EditWidth=80;
input int      EditHeight=20;
input color    TextColour=clrWhite;

datetime starttime;
string Prefix="OBJECT:";

string objlist[] = {
   "RectangleLabel",
   "Signal1",
   "Signal",
   "PendingOrders1",
   "PendingOrders",
   "ClosedOrders1",
   "ClosedOrders",
   "TotalOrders1",
   "TotalOrders",
   "Profit1",
   "Profit",
   "Equity1",
   "Equity",
   "Balance1",
   "Balance"
 };
string buttonlist[][4] = 
   {
      //{"RectangleLabel","0","0","clrBurlyWood"},
      {"Buy","15","190","clrGreen"},
      {"Sell","150","190","clrRed"},
      {"Buy Stop","15","215","clrGreen"},
      {"Sell Stop","150","215","clrRed"},
      {"Buy Limit","15","240","clrGreen"},
      {"Sell Limit","150","240","clrRed"},
      {"Buy Stop Limit","15","265","clrGreen"},
      {"Sell Stop Limit","150","265","clrRed"},
      {"Buy Close","15","290","clrGreen"},
      {"Sell Close","150","290","clrRed"},
      {"Profit Close","15","315","clrGreen"},
      {"Loss Close","150","315","clrRed"},
      {"Cancel All","15","340","clrGreen"},
      {"Close All","150","340","clrRed"},
   };

string obname="";

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   starttime = TimeCurrent();
   obname=Prefix+"RectangleLabel";
   ObjectCreate(0,obname,OBJ_RECTANGLE_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,275);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,400);
   ObjectSetInteger(0,obname,OBJPROP_BGCOLOR,clrBurlyWood);
   
   
   for(int i=0;i<ArraySize(buttonlist)/4;i++)
   {
      obname=Prefix+buttonlist[i][0];
      ObjectCreate(0,obname,OBJ_BUTTON,0,0,0);
      ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+(int)buttonlist[i][1]);
      ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+(int)buttonlist[i][2]);
      ObjectSetInteger(0,obname,OBJPROP_XSIZE,110);
      ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
      ObjectSetString(0,obname,OBJPROP_TEXT,buttonlist[i][0]);
      ObjectSetInteger(0,obname,OBJPROP_BGCOLOR,StringToColor(buttonlist[i][3]));
      ObjectSetInteger(0,obname,OBJPROP_COLOR,clrWhite);
      ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"9");
   }
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   for(int i=0;i<ArraySize(buttonlist)/4;i++)
   {
      ObjectDelete(0,Prefix+buttonlist[i][0]);
   }
   for(int i=0;i<ArraySize(objlist);i++)
   {
      ObjectDelete(0,Prefix+objlist[i]);
   }
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
       Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
       Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
         
       HistorySelect(starttime,TimeCurrent());
       double   Balance        = AccountInfoDouble(ACCOUNT_BALANCE);
       double   Equity         = AccountInfoDouble(ACCOUNT_EQUITY);
       double   Profit         = AccountInfoDouble(ACCOUNT_PROFIT);
       int      TotalOrders    = HistoryOrdersTotal();
       int      ClosedOrders   = TotalOrders - PositionsTotal();
       int      PendingOrders  = PositionsTotal();
       string   Signal         = "";
   
         comnt(Balance,Equity,Profit,TotalOrders, ClosedOrders,PendingOrders,Signal); //comment for the BOT
  }
//+------------------------------------------------------------------+

void OnChartEvent(const int id,
                   const long &lparam,
                   const double &dparam,
                   const string &sparam)
{
   Print("asdasdasd");
   if(id == CHARTEVENT_OBJECT_CLICK)
   {
      Print("clicked");
      if(sparam == Prefix+"Buy")
      {
         trades.Buy(0.01,NULL,Ask,(Ask-300*_Point),(Ask+500*_Point),"buy");
      }
      if(sparam == Prefix+"Sell")
      {
         trades.Sell(0.10,NULL,Bid,(Bid+300*_Point), (Bid-500*_Point),"sell");
      }
      
      if(sparam == Prefix+"Buy Stop")
      {
         event.BuyStop();
      }
      
      if(sparam == Prefix+"Sell Stop")
      {
         event.SellStop();
      }
      
      if(sparam == Prefix+"Buy Limit")
      {
         event.Buylimit();
      }
      
      if(sparam == Prefix+"Sell Limit")
      {
         event.SellLimit();
      }
      
      if(sparam == Prefix+"Buy Close")
      {
         event.BuyClose();
      }
      
      if(sparam == Prefix+"Sell Close")
      {
         event.SellClose();
      }
      
      if(sparam == Prefix+"Profit Close")
      {
         event.ProfitClose();
      }
      
      if(sparam == Prefix+"Loss Close")
      {
         event.LossClose();
      }
      
      if(sparam == Prefix+"Close All")
      {
         event.CloseAll();
      }
      
      if(sparam == Prefix+"Cancel All")
      {
         event.CancelAll();
      }
   }
   
}

void comnt(double Balance,double Equity,double Profit,int TotalOrders,int ClosedOrders,int PendingOrders,string Signal)
{
   obname=Prefix+"Balance";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+5);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+10);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT," Balance");
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"Balance1";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+150);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+10);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT,":  " + (string)Balance);
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"Equity";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+5);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+35);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT," Equity");
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"Equity1";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+150);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+35);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT,":  " + (string)Equity);
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"Profit";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+5);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+60);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT," Profit");
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"Profit1";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+150);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+60);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT,":  " + (string)Profit);
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"TotalOrders";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+5);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+85);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT," Total Orders");
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"TotalOrders1";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+150);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+85);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT,":  " + (string)TotalOrders);
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"ClosedOrders";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+5);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+110);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT," Closed Orders");
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"ClosedOrders1";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+150);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+110);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT,":  " + (string)ClosedOrders);
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"PendingOrders";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+5);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+135);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT," Pending Orders");
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"PendingOrders1";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+150);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+135);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT,":  " + (string)PendingOrders);
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"Signal";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+5);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+160);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT," Signal");
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
   obname=Prefix+"Signal1";
   ObjectCreate(0,obname,OBJ_LABEL,0,0,0);
   ObjectSetInteger(0,obname,OBJPROP_XDISTANCE,Xco+150);
   ObjectSetInteger(0,obname,OBJPROP_YDISTANCE,Yco+160);
   ObjectSetInteger(0,obname,OBJPROP_XSIZE,EditWidth);
   ObjectSetInteger(0,obname,OBJPROP_YSIZE,EditHeight);
   ObjectSetString(0,obname,OBJPROP_TEXT,":  " + (string)Signal);
   ObjectSetInteger(0,obname,OBJPROP_COLOR,TextColour);
   ObjectSetInteger(0,obname,OBJPROP_FONTSIZE,(int)"12");
   
}