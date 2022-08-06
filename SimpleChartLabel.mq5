
void OnTick()
  {
      double Ask =NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK),_Digits);
      
      ObjectCreate(_Symbol, "Label1", OBJ_LABEL, 0,0,0);
      
      ObjectSetString(0,"Label1", OBJPROP_FONT,"Arial");
      
      ObjectSetInteger(0, "Label1", OBJPROP_FONTSIZE, 24);
      
      ObjectSetString(0,"Label1", OBJPROP_TEXT,0,"Ask Price:"+Ask);
      
      ObjectSetInteger(0, "Label1", OBJPROP_XDISTANCE, 5);
      
      ObjectSetInteger(0, "Label1", OBJPROP_YDISTANCE, 10);

  }

