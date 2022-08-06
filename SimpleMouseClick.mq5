
void OnTick()
  {

   
  }

void OnChartEvent(const int id, const long& lparam, const double& dparam, const string& sparam)
{
   if(id == CHARTEVENT_CLICK)
   
   MessageBox("Chart was clicked "+" X-Value: "+lparam+" Y-Value: "+dparam, "Message: ", MB_OK);
}