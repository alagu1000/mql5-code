
void OnTick()
  {

   
  }

void OnChartEvent(const int EvendID,
                  const long& lparam,
                  const double& dparam,
                  const string& sparam)
{
   if(EvendID ==CHARTEVENT_KEYDOWN)
   {
      short KeyThatWasPressed = TranslateKey((int)lparam);
   
      MessageBox("The key was : "+ ShortToString(KeyThatWasPressed), "Key was Pressed", MB_OK);
   }
   
}