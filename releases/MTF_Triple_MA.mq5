//+------------------------------------------------------------------+
//|                                             MTF_Triple_MA.mq5    |
//|                                                             FxTT  |
//+------------------------------------------------------------------+
#property copyright "FxTT"
#property link      ""
#property version   "1.00"
#property description "Triple Moving Average Multi-Timeframe Panel"

#property indicator_chart_window
#property indicator_buffers 27
#property indicator_plots   27

//--- Plots: MN1
#property indicator_label1  "MA Fast MN1"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrMagenta
#property indicator_style1  STYLE_DOT
#property indicator_width1  1

#property indicator_label2  "MA Med MN1"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrMagenta
#property indicator_style2  STYLE_DASH
#property indicator_width2  1

#property indicator_label3  "MA Slow MN1"
#property indicator_type3   DRAW_LINE
#property indicator_color3  clrMagenta
#property indicator_style3  STYLE_SOLID
#property indicator_width3  2

//--- Plots: W1
#property indicator_label4  "MA Fast W1"
#property indicator_type4   DRAW_LINE
#property indicator_color4  clrDodgerBlue
#property indicator_style4  STYLE_DOT
#property indicator_width4  1

#property indicator_label5  "MA Med W1"
#property indicator_type5   DRAW_LINE
#property indicator_color5  clrDodgerBlue
#property indicator_style5  STYLE_DASH
#property indicator_width5  1

#property indicator_label6  "MA Slow W1"
#property indicator_type6   DRAW_LINE
#property indicator_color6  clrDodgerBlue
#property indicator_style6  STYLE_SOLID
#property indicator_width6  2

//--- Plots: D1
#property indicator_label7  "MA Fast D1"
#property indicator_type7   DRAW_LINE
#property indicator_color7  clrOrange
#property indicator_style7  STYLE_DOT
#property indicator_width7  1

#property indicator_label8  "MA Med D1"
#property indicator_type8   DRAW_LINE
#property indicator_color8  clrOrange
#property indicator_style8  STYLE_DASH
#property indicator_width8  1

#property indicator_label9  "MA Slow D1"
#property indicator_type9   DRAW_LINE
#property indicator_color9  clrOrange
#property indicator_style9  STYLE_SOLID
#property indicator_width9  2

//--- Plots: H4
#property indicator_label10 "MA Fast H4"
#property indicator_type10  DRAW_LINE
#property indicator_color10 clrLimeGreen
#property indicator_style10 STYLE_DOT
#property indicator_width10 1

#property indicator_label11 "MA Med H4"
#property indicator_type11  DRAW_LINE
#property indicator_color11 clrLimeGreen
#property indicator_style11 STYLE_DASH
#property indicator_width11 1

#property indicator_label12 "MA Slow H4"
#property indicator_type12  DRAW_LINE
#property indicator_color12 clrLimeGreen
#property indicator_style12 STYLE_SOLID
#property indicator_width12 2

//--- Plots: H1
#property indicator_label13 "MA Fast H1"
#property indicator_type13  DRAW_LINE
#property indicator_color13 clrGold
#property indicator_style13 STYLE_DOT
#property indicator_width13 1

#property indicator_label14 "MA Med H1"
#property indicator_type14  DRAW_LINE
#property indicator_color14 clrGold
#property indicator_style14 STYLE_DASH
#property indicator_width14 1

#property indicator_label15 "MA Slow H1"
#property indicator_type15  DRAW_LINE
#property indicator_color15 clrGold
#property indicator_style15 STYLE_SOLID
#property indicator_width15 2

//--- Plots: M30
#property indicator_label16 "MA Fast M30"
#property indicator_type16  DRAW_LINE
#property indicator_color16 clrTomato
#property indicator_style16 STYLE_DOT
#property indicator_width16 1

#property indicator_label17 "MA Med M30"
#property indicator_type17  DRAW_LINE
#property indicator_color17 clrTomato
#property indicator_style17 STYLE_DASH
#property indicator_width17 1

#property indicator_label18 "MA Slow M30"
#property indicator_type18  DRAW_LINE
#property indicator_color18 clrTomato
#property indicator_style18 STYLE_SOLID
#property indicator_width18 2

//--- Plots: M15
#property indicator_label19 "MA Fast M15"
#property indicator_type19  DRAW_LINE
#property indicator_color19 clrDeepSkyBlue
#property indicator_style19 STYLE_DOT
#property indicator_width19 1

#property indicator_label20 "MA Med M15"
#property indicator_type20  DRAW_LINE
#property indicator_color20 clrDeepSkyBlue
#property indicator_style20 STYLE_DASH
#property indicator_width20 1

#property indicator_label21 "MA Slow M15"
#property indicator_type21  DRAW_LINE
#property indicator_color21 clrDeepSkyBlue
#property indicator_style21 STYLE_SOLID
#property indicator_width21 2

//--- Plots: M5
#property indicator_label22 "MA Fast M5"
#property indicator_type22  DRAW_LINE
#property indicator_color22 clrViolet
#property indicator_style22 STYLE_DOT
#property indicator_width22 1

#property indicator_label23 "MA Med M5"
#property indicator_type23  DRAW_LINE
#property indicator_color23 clrViolet
#property indicator_style23 STYLE_DASH
#property indicator_width23 1

#property indicator_label24 "MA Slow M5"
#property indicator_type24  DRAW_LINE
#property indicator_color24 clrViolet
#property indicator_style24 STYLE_SOLID
#property indicator_width24 2

//--- Plots: M1
#property indicator_label25 "MA Fast M1"
#property indicator_type25  DRAW_LINE
#property indicator_color25 clrSilver
#property indicator_style25 STYLE_DOT
#property indicator_width25 1

#property indicator_label26 "MA Med M1"
#property indicator_type26  DRAW_LINE
#property indicator_color26 clrSilver
#property indicator_style26 STYLE_DASH
#property indicator_width26 1

#property indicator_label27 "MA Slow M1"
#property indicator_type27  DRAW_LINE
#property indicator_color27 clrSilver
#property indicator_style27 STYLE_SOLID
#property indicator_width27 2

//+------------------------------------------------------------------+
//| Input parameters                                                  |
//+------------------------------------------------------------------+
input group "Moving Averages"
input int                InpFastPeriod = 50;          // Fast MA Period
input int                InpMedPeriod  = 100;         // Medium MA Period
input int                InpSlowPeriod = 200;         // Slow MA Period
input ENUM_MA_METHOD     InpMAMethod   = MODE_EMA;    // MA Method
input ENUM_APPLIED_PRICE InpMAPrice    = PRICE_CLOSE; // Applied Price
input int                InpMAShift    = 0;           // MA Shift

input group "Panel"
input int  InpPanelX = 20; // Panel X (pixels from corner)
input int  InpPanelY = 30; // Panel Y (pixels from corner)

input group "Labels"
input bool InpShowLabels     = true; // Show right-side labels
input int  InpLabelShiftBars = 1;    // Label shift (bars)
input int  InpLabelFontSize  = 8;    // Label font size

//+------------------------------------------------------------------+
//| Constants                                                         |
//+------------------------------------------------------------------+
#define TF_COUNT 9

enum ETFIndex
{
   TF_MN1 = 0,
   TF_W1  = 1,
   TF_D1  = 2,
   TF_H4  = 3,
   TF_H1  = 4,
   TF_M30 = 5,
   TF_M15 = 6,
   TF_M5  = 7,
   TF_M1  = 8
};

//+------------------------------------------------------------------+
//| Indicator buffers  (9 TFs x 3 MAs = 27)                          |
//+------------------------------------------------------------------+
double g_MN1Fast[], g_MN1Med[], g_MN1Slow[];
double g_W1Fast[],  g_W1Med[],  g_W1Slow[];
double g_D1Fast[],  g_D1Med[],  g_D1Slow[];
double g_H4Fast[],  g_H4Med[],  g_H4Slow[];
double g_H1Fast[],  g_H1Med[],  g_H1Slow[];
double g_M30Fast[], g_M30Med[], g_M30Slow[];
double g_M15Fast[], g_M15Med[], g_M15Slow[];
double g_M5Fast[],  g_M5Med[],  g_M5Slow[];
double g_M1Fast[],  g_M1Med[],  g_M1Slow[];

//+------------------------------------------------------------------+
//| MA handles  [tfIndex][0=fast, 1=med, 2=slow]                     |
//+------------------------------------------------------------------+
int g_Hnd[TF_COUNT][3];

//+------------------------------------------------------------------+
//| New-bar detection                                                 |
//+------------------------------------------------------------------+
datetime g_LastBarTime = 0;
datetime g_LastMN1Time = 0;
datetime g_LastW1Time  = 0;
datetime g_LastD1Time  = 0;
datetime g_LastH4Time  = 0;
datetime g_LastH1Time  = 0;
datetime g_LastM30Time = 0;
datetime g_LastM15Time = 0;
datetime g_LastM5Time  = 0;
datetime g_LastM1Time  = 0;

//+------------------------------------------------------------------+
//| Cached time array                                                 |
//+------------------------------------------------------------------+
int      g_RatesTotal = 0;
datetime g_Time[];

//+------------------------------------------------------------------+
//| Panel / visibility state                                          |
//+------------------------------------------------------------------+
bool g_Expanded = true;

bool g_ShowMN1 = true;
bool g_ShowW1  = true;
bool g_ShowD1  = true;
bool g_ShowH4  = true;
bool g_ShowH1  = true;
bool g_ShowM30 = true;
bool g_ShowM15 = true;
bool g_ShowM5  = true;
bool g_ShowM1  = true;

bool g_PrevShowMN1 = true;
bool g_PrevShowW1  = true;
bool g_PrevShowD1  = true;
bool g_PrevShowH4  = true;
bool g_PrevShowH1  = true;
bool g_PrevShowM30 = true;
bool g_PrevShowM15 = true;
bool g_PrevShowM5  = true;
bool g_PrevShowM1  = true;

bool g_EligibleMN1 = true;
bool g_EligibleW1  = true;
bool g_EligibleD1  = true;
bool g_EligibleH4  = true;
bool g_EligibleH1  = true;
bool g_EligibleM30 = true;
bool g_EligibleM15 = true;
bool g_EligibleM5  = true;
bool g_EligibleM1  = true;

//+------------------------------------------------------------------+
//| Panel position                                                    |
//+------------------------------------------------------------------+
int g_PanelX = 0;
int g_PanelY = 0;

//+------------------------------------------------------------------+
//| Drag state                                                        |
//+------------------------------------------------------------------+
bool g_Dragging        = false;
bool g_ActuallyDragged = false;
bool g_WasLBDown       = false;
int  g_DragOffX        = 0;
int  g_DragOffY        = 0;
int  g_DragStartX      = 0;
int  g_DragStartY      = 0;

const int DRAG_THRESHOLD = 4;

//+------------------------------------------------------------------+
//| Object-name prefix                                                |
//+------------------------------------------------------------------+
string g_Pfx;

//+------------------------------------------------------------------+
//| Panel layout constants                                            |
//+------------------------------------------------------------------+
const int PANEL_W  = 230;
const int TOGGLE_H = 24;
const int CHECK_H  = 22;
const int PADDING  = 4;
const int GAP      = 2;

const color CLR_PANEL_BG       = C'18,26,42';
const color CLR_PANEL_BORDER   = C'55,85,130';
const color CLR_TOGGLE_BG      = C'35,55,90';
const color CLR_CHECK_BG_ON    = C'28,44,68';
const color CLR_CHECK_BG_OFF   = C'16,22,34';
const color CLR_UNCHECKED_TEXT = C'70,85,100';
const color CLR_DISABLED_BG    = C'14,18,24';
const color CLR_DISABLED_TEXT  = C'40,48,58';

//+------------------------------------------------------------------+
//| Helpers                                                           |
//+------------------------------------------------------------------+
string N(const string name)       { return g_Pfx + name; }
int    PlotBaseByIndex(int index)  { return index * 3; }

int PanelHeight(bool expanded)
{
   if(expanded)
      return PADDING + TOGGLE_H + GAP + TF_COUNT * (CHECK_H + GAP) + PADDING;
   return PADDING + TOGGLE_H + PADDING;
}

string GVK(const string suffix)
{
   return "TRMTF_" + IntegerToString(ChartID()) + "_" + suffix;
}

ENUM_TIMEFRAMES TFByIndex(const int index)
{
   switch(index)
   {
      case TF_MN1: return PERIOD_MN1;
      case TF_W1:  return PERIOD_W1;
      case TF_D1:  return PERIOD_D1;
      case TF_H4:  return PERIOD_H4;
      case TF_H1:  return PERIOD_H1;
      case TF_M30: return PERIOD_M30;
      case TF_M15: return PERIOD_M15;
      case TF_M5:  return PERIOD_M5;
      case TF_M1:  return PERIOD_M1;
   }
   return PERIOD_CURRENT;
}

string TfLabelByIndex(const int index)
{
   switch(index)
   {
      case TF_MN1: return "MN1";
      case TF_W1:  return "W1";
      case TF_D1:  return "D1";
      case TF_H4:  return "H4";
      case TF_H1:  return "H1";
      case TF_M30: return "M30";
      case TF_M15: return "M15";
      case TF_M5:  return "M5";
      case TF_M1:  return "M1";
   }
   return "";
}

string MASpeedLabel(const int maIndex)
{
   switch(maIndex)
   {
      case 0: return StringFormat("MA%d", InpFastPeriod);
      case 1: return StringFormat("MA%d", InpMedPeriod);
      case 2: return StringFormat("MA%d", InpSlowPeriod);
   }
   return "";
}

string PlotLabel(const int plotIndex)
{
   return MASpeedLabel(plotIndex % 3) + " " + TfLabelByIndex(plotIndex / 3);
}

color AccentColorByIndex(const int index)
{
   switch(index)
   {
      case TF_MN1: return clrMagenta;
      case TF_W1:  return clrDodgerBlue;
      case TF_D1:  return clrOrange;
      case TF_H4:  return clrLimeGreen;
      case TF_H1:  return clrGold;
      case TF_M30: return clrTomato;
      case TF_M15: return clrDeepSkyBlue;
      case TF_M5:  return clrViolet;
      case TF_M1:  return clrSilver;
   }
   return clrWhite;
}

string CheckboxIdByIndex(const int index)
{
   switch(index)
   {
      case TF_MN1: return "CbMN1";
      case TF_W1:  return "CbW1";
      case TF_D1:  return "CbD1";
      case TF_H4:  return "CbH4";
      case TF_H1:  return "CbH1";
      case TF_M30: return "CbM30";
      case TF_M15: return "CbM15";
      case TF_M5:  return "CbM5";
      case TF_M1:  return "CbM1";
   }
   return "";
}

string CheckboxLabelByIndex(const int index)
{
   switch(index)
   {
      case TF_MN1: return "■  Triple MA  MN1";
      case TF_W1:  return "■  Triple MA  W1";
      case TF_D1:  return "■  Triple MA  D1";
      case TF_H4:  return "■  Triple MA  H4";
      case TF_H1:  return "■  Triple MA  H1";
      case TF_M30: return "■  Triple MA  M30";
      case TF_M15: return "■  Triple MA  M15";
      case TF_M5:  return "■  Triple MA  M5";
      case TF_M1:  return "■  Triple MA  M1";
   }
   return "";
}

//+------------------------------------------------------------------+
//| State persistence                                                 |
//+------------------------------------------------------------------+
void State_Save()
{
   GlobalVariableSet(GVK("X"),        g_PanelX);
   GlobalVariableSet(GVK("Y"),        g_PanelY);
   GlobalVariableSet(GVK("Expanded"), g_Expanded ? 1.0 : 0.0);
   GlobalVariableSet(GVK("ShowMN1"),  g_ShowMN1  ? 1.0 : 0.0);
   GlobalVariableSet(GVK("ShowW1"),   g_ShowW1   ? 1.0 : 0.0);
   GlobalVariableSet(GVK("ShowD1"),   g_ShowD1   ? 1.0 : 0.0);
   GlobalVariableSet(GVK("ShowH4"),   g_ShowH4   ? 1.0 : 0.0);
   GlobalVariableSet(GVK("ShowH1"),   g_ShowH1   ? 1.0 : 0.0);
   GlobalVariableSet(GVK("ShowM30"),  g_ShowM30  ? 1.0 : 0.0);
   GlobalVariableSet(GVK("ShowM15"),  g_ShowM15  ? 1.0 : 0.0);
   GlobalVariableSet(GVK("ShowM5"),   g_ShowM5   ? 1.0 : 0.0);
   GlobalVariableSet(GVK("ShowM1"),   g_ShowM1   ? 1.0 : 0.0);
}

bool State_Load()
{
   if(!GlobalVariableCheck(GVK("X")))
      return false;

   g_PanelX   = (int)GlobalVariableGet(GVK("X"));
   g_PanelY   = (int)GlobalVariableGet(GVK("Y"));
   g_Expanded = GlobalVariableGet(GVK("Expanded")) != 0.0;

   if(GlobalVariableCheck(GVK("ShowMN1"))) g_ShowMN1 = GlobalVariableGet(GVK("ShowMN1")) != 0.0;
   if(GlobalVariableCheck(GVK("ShowW1")))  g_ShowW1  = GlobalVariableGet(GVK("ShowW1"))  != 0.0;
   if(GlobalVariableCheck(GVK("ShowD1")))  g_ShowD1  = GlobalVariableGet(GVK("ShowD1"))  != 0.0;
   if(GlobalVariableCheck(GVK("ShowH4")))  g_ShowH4  = GlobalVariableGet(GVK("ShowH4"))  != 0.0;
   if(GlobalVariableCheck(GVK("ShowH1")))  g_ShowH1  = GlobalVariableGet(GVK("ShowH1"))  != 0.0;
   if(GlobalVariableCheck(GVK("ShowM30"))) g_ShowM30 = GlobalVariableGet(GVK("ShowM30")) != 0.0;
   if(GlobalVariableCheck(GVK("ShowM15"))) g_ShowM15 = GlobalVariableGet(GVK("ShowM15")) != 0.0;
   if(GlobalVariableCheck(GVK("ShowM5")))  g_ShowM5  = GlobalVariableGet(GVK("ShowM5"))  != 0.0;
   if(GlobalVariableCheck(GVK("ShowM1")))  g_ShowM1  = GlobalVariableGet(GVK("ShowM1"))  != 0.0;

   return true;
}

void State_Delete()
{
   GlobalVariableDel(GVK("X"));
   GlobalVariableDel(GVK("Y"));
   GlobalVariableDel(GVK("Expanded"));
   GlobalVariableDel(GVK("ShowMN1"));
   GlobalVariableDel(GVK("ShowW1"));
   GlobalVariableDel(GVK("ShowD1"));
   GlobalVariableDel(GVK("ShowH4"));
   GlobalVariableDel(GVK("ShowH1"));
   GlobalVariableDel(GVK("ShowM30"));
   GlobalVariableDel(GVK("ShowM15"));
   GlobalVariableDel(GVK("ShowM5"));
   GlobalVariableDel(GVK("ShowM1"));
}

//+------------------------------------------------------------------+
//| Label objects                                                     |
//+------------------------------------------------------------------+
int SecondsPerCurrentBar()
{
   int s = PeriodSeconds(Period());
   return (s > 0) ? s : 60;
}

void DeleteMALabel(const int plotIndex)
{
   ObjectDelete(0, N("MALbl_" + IntegerToString(plotIndex)));
}

void SetMALabel(const int plotIndex, const bool visible,
                const datetime baseTime, const double price,
                const int barSeconds)
{
   if(!InpShowLabels || !visible || price == EMPTY_VALUE || !MathIsValidNumber(price))
   {
      DeleteMALabel(plotIndex);
      return;
   }

   string   obj  = N("MALbl_" + IntegerToString(plotIndex));
   datetime when = baseTime + (datetime)(MathMax(0, InpLabelShiftBars) * barSeconds);

   if(ObjectFind(0, obj) < 0)
      ObjectCreate(0, obj, OBJ_TEXT, 0, when, price);
   else
      ObjectMove(0, obj, 0, when, price);

   ObjectSetString(0,  obj, OBJPROP_TEXT,      PlotLabel(plotIndex));
   ObjectSetInteger(0, obj, OBJPROP_COLOR,      AccentColorByIndex(plotIndex / 3));
   ObjectSetInteger(0, obj, OBJPROP_ANCHOR,     ANCHOR_LEFT);
   ObjectSetInteger(0, obj, OBJPROP_FONTSIZE,   InpLabelFontSize);
   ObjectSetString(0,  obj, OBJPROP_FONT,       "Segoe UI");
   ObjectSetInteger(0, obj, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, obj, OBJPROP_HIDDEN,     true);
   ObjectSetInteger(0, obj, OBJPROP_BACK,       false);
   ObjectSetInteger(0, obj, OBJPROP_ZORDER,     0);
}

void SetTFLabels(const int tfIndex, const bool visible,
                 const datetime baseTime, const int barSeconds,
                 double &fast[], double &med[], double &slow[])
{
   int base = PlotBaseByIndex(tfIndex);

   if(g_RatesTotal <= 0 || !visible)
   {
      DeleteMALabel(base);
      DeleteMALabel(base + 1);
      DeleteMALabel(base + 2);
      return;
   }

   int last = g_RatesTotal - 1;
   SetMALabel(base,     true, baseTime, fast[last],  barSeconds);
   SetMALabel(base + 1, true, baseTime, med[last],   barSeconds);
   SetMALabel(base + 2, true, baseTime, slow[last],  barSeconds);
}

void Labels_DeleteAll()
{
   for(int i = 0; i < 27; i++)
      DeleteMALabel(i);
}

void Labels_Refresh()
{
   if(!InpShowLabels || g_RatesTotal <= 0 || ArraySize(g_Time) <= 0)
   {
      Labels_DeleteAll();
      return;
   }

   datetime baseTime = g_Time[g_RatesTotal - 1];
   if(baseTime <= 0) { Labels_DeleteAll(); return; }

   int bsecs = SecondsPerCurrentBar();

   SetTFLabels(TF_MN1, g_ShowMN1 && g_EligibleMN1, baseTime, bsecs, g_MN1Fast, g_MN1Med, g_MN1Slow);
   SetTFLabels(TF_W1,  g_ShowW1  && g_EligibleW1,  baseTime, bsecs, g_W1Fast,  g_W1Med,  g_W1Slow);
   SetTFLabels(TF_D1,  g_ShowD1  && g_EligibleD1,  baseTime, bsecs, g_D1Fast,  g_D1Med,  g_D1Slow);
   SetTFLabels(TF_H4,  g_ShowH4  && g_EligibleH4,  baseTime, bsecs, g_H4Fast,  g_H4Med,  g_H4Slow);
   SetTFLabels(TF_H1,  g_ShowH1  && g_EligibleH1,  baseTime, bsecs, g_H1Fast,  g_H1Med,  g_H1Slow);
   SetTFLabels(TF_M30, g_ShowM30 && g_EligibleM30, baseTime, bsecs, g_M30Fast, g_M30Med, g_M30Slow);
   SetTFLabels(TF_M15, g_ShowM15 && g_EligibleM15, baseTime, bsecs, g_M15Fast, g_M15Med, g_M15Slow);
   SetTFLabels(TF_M5,  g_ShowM5  && g_EligibleM5,  baseTime, bsecs, g_M5Fast,  g_M5Med,  g_M5Slow);
   SetTFLabels(TF_M1,  g_ShowM1  && g_EligibleM1,  baseTime, bsecs, g_M1Fast,  g_M1Med,  g_M1Slow);
}

//+------------------------------------------------------------------+
//| Low-level panel object builders                                   |
//+------------------------------------------------------------------+
void _CreateBackground(const string name, int x, int y, int w, int h)
{
   if(ObjectFind(0, name) < 0)
      ObjectCreate(0, name, OBJ_RECTANGLE_LABEL, 0, 0, 0);

   ObjectSetInteger(0, name, OBJPROP_XDISTANCE,   x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE,   y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE,        w);
   ObjectSetInteger(0, name, OBJPROP_YSIZE,        h);
   ObjectSetInteger(0, name, OBJPROP_CORNER,       CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR,      CLR_PANEL_BG);
   ObjectSetInteger(0, name, OBJPROP_BORDER_TYPE,  BORDER_FLAT);
   ObjectSetInteger(0, name, OBJPROP_COLOR,        CLR_PANEL_BORDER);
   ObjectSetInteger(0, name, OBJPROP_WIDTH,        1);
   ObjectSetInteger(0, name, OBJPROP_BACK,         false);
   ObjectSetInteger(0, name, OBJPROP_SELECTABLE,   false);
   ObjectSetInteger(0, name, OBJPROP_HIDDEN,       true);
   ObjectSetInteger(0, name, OBJPROP_ZORDER,       1);
}

void _CreateButton(const string name, int x, int y, int w, int h,
                   const string text, color bg, color fg,
                   int fontsize = 9, bool state = false)
{
   if(ObjectFind(0, name) < 0)
      ObjectCreate(0, name, OBJ_BUTTON, 0, 0, 0);

   ObjectSetInteger(0, name, OBJPROP_XDISTANCE,    x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE,    y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE,         w);
   ObjectSetInteger(0, name, OBJPROP_YSIZE,         h);
   ObjectSetInteger(0, name, OBJPROP_CORNER,        CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR,       bg);
   ObjectSetInteger(0, name, OBJPROP_COLOR,         fg);
   ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR,  CLR_PANEL_BORDER);
   ObjectSetString(0,  name, OBJPROP_TEXT,          text);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE,      fontsize);
   ObjectSetString(0,  name, OBJPROP_FONT,          "Segoe UI");
   ObjectSetInteger(0, name, OBJPROP_STATE,         state);
   ObjectSetInteger(0, name, OBJPROP_SELECTABLE,    false);
   ObjectSetInteger(0, name, OBJPROP_HIDDEN,        true);
   ObjectSetInteger(0, name, OBJPROP_ZORDER,        10);
}

//+------------------------------------------------------------------+
//| Plot / buffer helpers                                             |
//+------------------------------------------------------------------+
void SetPlotVisibility(int plotBase, bool show)
{
   for(int j = 0; j < 3; j++)
      PlotIndexSetInteger(plotBase + j, PLOT_DRAW_TYPE, show ? DRAW_LINE : DRAW_NONE);
}

void ClearMA(double &fast[], double &med[], double &slow[])
{
   ArrayInitialize(fast, EMPTY_VALUE);
   ArrayInitialize(med,  EMPTY_VALUE);
   ArrayInitialize(slow, EMPTY_VALUE);
}

// Fills a single MA destination buffer by mapping HTF bars onto the chart time axis.
void FillMTFBuffer(int handle, ENUM_TIMEFRAMES tf,
                   double &dest[], int start, int total,
                   const datetime &time[])
{
   if(start >= total)
      return;

   int nHTF = (int)BarsCalculated(handle);
   if(nHTF <= 0)
   {
      ArrayFill(dest, start, total - start, EMPTY_VALUE);
      return;
   }

   double   htfBuf[];
   datetime htfTime[];
   ArraySetAsSeries(htfBuf,  true);
   ArraySetAsSeries(htfTime, true);

   int copiedBuf  = CopyBuffer(handle, 0, 0, nHTF, htfBuf);
   int copiedTime = CopyTime(_Symbol, tf, 0, nHTF, htfTime);

   if(copiedBuf <= 0 || copiedTime <= 0)
   {
      ArrayFill(dest, start, total - start, EMPTY_VALUE);
      return;
   }

   int htfSize = MathMin(copiedBuf, copiedTime);
   int j       = 0;

   for(int i = total - 1; i >= start; i--)
   {
      while(j < htfSize - 1 && htfTime[j] > time[i])
         j++;
      dest[i] = (j < htfSize && htfTime[j] <= time[i]) ? htfBuf[j] : EMPTY_VALUE;
   }
}

void FillTFMAs(const int tfIndex, int start, int total, const datetime &time[],
               double &fast[], double &med[], double &slow[])
{
   ENUM_TIMEFRAMES tf = TFByIndex(tfIndex);
   FillMTFBuffer(g_Hnd[tfIndex][0], tf, fast, start, total, time);
   FillMTFBuffer(g_Hnd[tfIndex][1], tf, med,  start, total, time);
   FillMTFBuffer(g_Hnd[tfIndex][2], tf, slow, start, total, time);
}

bool TFHandlesReady(const int tfIndex)
{
   return BarsCalculated(g_Hnd[tfIndex][0]) > 0 &&
          BarsCalculated(g_Hnd[tfIndex][1]) > 0 &&
          BarsCalculated(g_Hnd[tfIndex][2]) > 0;
}

//+------------------------------------------------------------------+
//| Panel helpers                                                     |
//+------------------------------------------------------------------+
void Panel_UpdateCheckbox(const string id, bool checked, color accentClr)
{
   ObjectSetInteger(0, N(id), OBJPROP_STATE,  checked);
   ObjectSetInteger(0, N(id), OBJPROP_BGCOLOR, checked ? CLR_CHECK_BG_ON : CLR_CHECK_BG_OFF);
   ObjectSetInteger(0, N(id), OBJPROP_COLOR,   checked ? accentClr : CLR_UNCHECKED_TEXT);
}

void ToggleTF(const string checkboxId,
              bool &showState, bool eligible, bool &prevShowState,
              const color accentClr, const int tfIndex,
              double &fast[], double &med[], double &slow[])
{
   if(!eligible)
   {
      ObjectSetInteger(0, N(checkboxId), OBJPROP_STATE, false);
      return;
   }

   showState = (bool)ObjectGetInteger(0, N(checkboxId), OBJPROP_STATE);
   Panel_UpdateCheckbox(checkboxId, showState, accentClr);
   SetPlotVisibility(PlotBaseByIndex(tfIndex), showState);

   if(showState)
   {
      FillTFMAs(tfIndex, 0, g_RatesTotal, g_Time, fast, med, slow);
      prevShowState = true;
   }
   else
      ClearMA(fast, med, slow);

   Labels_Refresh();
   State_Save();
   ChartRedraw(0);
}

//+------------------------------------------------------------------+
//| Panel create / delete / move / expand                             |
//+------------------------------------------------------------------+
void Panel_Create()
{
   int x  = g_PanelX;
   int y  = g_PanelY;
   int bx = x + PADDING;
   int bw = PANEL_W - 2 * PADDING;

   _CreateBackground(N("BG"), x, y, PANEL_W, PanelHeight(g_Expanded));
   _CreateButton(N("Toggle"), bx, y + PADDING, bw, TOGGLE_H,
                 " Triple MA Panel  ▲", CLR_TOGGLE_BG, clrWhite, 9, false);

   int cy = y + PADDING + TOGGLE_H + GAP;
   for(int i = 0; i < TF_COUNT; i++)
   {
      bool   eligible = (i == TF_MN1) ? g_EligibleMN1 :
                        (i == TF_W1)  ? g_EligibleW1  :
                        (i == TF_D1)  ? g_EligibleD1  :
                        (i == TF_H4)  ? g_EligibleH4  :
                        (i == TF_H1)  ? g_EligibleH1  :
                        (i == TF_M30) ? g_EligibleM30 :
                        (i == TF_M15) ? g_EligibleM15 :
                        (i == TF_M5)  ? g_EligibleM5  : g_EligibleM1;
      bool   showSt  = (i == TF_MN1) ? (g_ShowMN1 && g_EligibleMN1) :
                        (i == TF_W1)  ? (g_ShowW1  && g_EligibleW1)  :
                        (i == TF_D1)  ? (g_ShowD1  && g_EligibleD1)  :
                        (i == TF_H4)  ? (g_ShowH4  && g_EligibleH4)  :
                        (i == TF_H1)  ? (g_ShowH1  && g_EligibleH1)  :
                        (i == TF_M30) ? (g_ShowM30 && g_EligibleM30) :
                        (i == TF_M15) ? (g_ShowM15 && g_EligibleM15) :
                        (i == TF_M5)  ? (g_ShowM5  && g_EligibleM5)  :
                                        (g_ShowM1  && g_EligibleM1);
      color  accent  = AccentColorByIndex(i);
      color  fg      = !eligible ? CLR_DISABLED_TEXT : (showSt ? accent : CLR_UNCHECKED_TEXT);
      color  bg      = !eligible ? CLR_DISABLED_BG   : (showSt ? CLR_CHECK_BG_ON : CLR_CHECK_BG_OFF);
      string id      = CheckboxIdByIndex(i);

      _CreateButton(N(id), bx, cy, bw, CHECK_H, CheckboxLabelByIndex(i), bg, fg, 9, showSt);
      ObjectSetInteger(0, N(id), OBJPROP_TIMEFRAMES, g_Expanded ? OBJ_ALL_PERIODS : OBJ_NO_PERIODS);
      cy += CHECK_H + GAP;
   }

   ObjectSetString(0, N("Toggle"), OBJPROP_TEXT,
                   g_Expanded ? " Triple MA Panel  ▲" : " Triple MA Panel  ▼");

   for(int i = 0; i < TF_COUNT; i++)
   {
      bool showSt = (i == TF_MN1) ? (g_ShowMN1 && g_EligibleMN1) :
                    (i == TF_W1)  ? (g_ShowW1  && g_EligibleW1)  :
                    (i == TF_D1)  ? (g_ShowD1  && g_EligibleD1)  :
                    (i == TF_H4)  ? (g_ShowH4  && g_EligibleH4)  :
                    (i == TF_H1)  ? (g_ShowH1  && g_EligibleH1)  :
                    (i == TF_M30) ? (g_ShowM30 && g_EligibleM30) :
                    (i == TF_M15) ? (g_ShowM15 && g_EligibleM15) :
                    (i == TF_M5)  ? (g_ShowM5  && g_EligibleM5)  :
                                    (g_ShowM1  && g_EligibleM1);
      SetPlotVisibility(PlotBaseByIndex(i), showSt);
   }

   Labels_Refresh();
   ChartRedraw(0);
}

void Panel_Delete()
{
   string objs[] =
   {
      "BG", "Toggle",
      "CbMN1", "CbW1", "CbD1", "CbH4", "CbH1", "CbM30", "CbM15", "CbM5", "CbM1"
   };
   for(int i = 0; i < ArraySize(objs); i++)
      ObjectDelete(0, N(objs[i]));

   Labels_DeleteAll();
}

void Panel_Move(int x, int y)
{
   g_PanelX = x;
   g_PanelY = y;

   int bx = x + PADDING;
   ObjectSetInteger(0, N("BG"),     OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, N("BG"),     OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, N("Toggle"), OBJPROP_XDISTANCE, bx);
   ObjectSetInteger(0, N("Toggle"), OBJPROP_YDISTANCE, y + PADDING);

   int cy = y + PADDING + TOGGLE_H + GAP;
   for(int i = 0; i < TF_COUNT; i++)
   {
      string id = CheckboxIdByIndex(i);
      ObjectSetInteger(0, N(id), OBJPROP_XDISTANCE, bx);
      ObjectSetInteger(0, N(id), OBJPROP_YDISTANCE, cy);
      cy += CHECK_H + GAP;
   }

   State_Save();
   ChartRedraw(0);
}

void Panel_SetExpanded(bool expand)
{
   g_Expanded = expand;
   ObjectSetInteger(0, N("BG"), OBJPROP_YSIZE, PanelHeight(expand));

   long vis = expand ? OBJ_ALL_PERIODS : OBJ_NO_PERIODS;
   for(int i = 0; i < TF_COUNT; i++)
      ObjectSetInteger(0, N(CheckboxIdByIndex(i)), OBJPROP_TIMEFRAMES, vis);

   ObjectSetString(0, N("Toggle"), OBJPROP_TEXT,
                   expand ? " Triple MA Panel  ▲" : " Triple MA Panel  ▼");

   State_Save();
   ChartRedraw(0);
}

//+------------------------------------------------------------------+
//| Init                                                              |
//+------------------------------------------------------------------+
int OnInit()
{
   g_Pfx = "TRMTF_" + IntegerToString(ChartID()) + "_";

   if(!State_Load())
   {
      g_PanelX = InpPanelX;
      g_PanelY = InpPanelY;
   }

   ChartSetInteger(0, CHART_EVENT_MOUSE_MOVE, true);

   //--- Register buffers
   SetIndexBuffer(0,  g_MN1Fast, INDICATOR_DATA);
   SetIndexBuffer(1,  g_MN1Med,  INDICATOR_DATA);
   SetIndexBuffer(2,  g_MN1Slow, INDICATOR_DATA);
   SetIndexBuffer(3,  g_W1Fast,  INDICATOR_DATA);
   SetIndexBuffer(4,  g_W1Med,   INDICATOR_DATA);
   SetIndexBuffer(5,  g_W1Slow,  INDICATOR_DATA);
   SetIndexBuffer(6,  g_D1Fast,  INDICATOR_DATA);
   SetIndexBuffer(7,  g_D1Med,   INDICATOR_DATA);
   SetIndexBuffer(8,  g_D1Slow,  INDICATOR_DATA);
   SetIndexBuffer(9,  g_H4Fast,  INDICATOR_DATA);
   SetIndexBuffer(10, g_H4Med,   INDICATOR_DATA);
   SetIndexBuffer(11, g_H4Slow,  INDICATOR_DATA);
   SetIndexBuffer(12, g_H1Fast,  INDICATOR_DATA);
   SetIndexBuffer(13, g_H1Med,   INDICATOR_DATA);
   SetIndexBuffer(14, g_H1Slow,  INDICATOR_DATA);
   SetIndexBuffer(15, g_M30Fast, INDICATOR_DATA);
   SetIndexBuffer(16, g_M30Med,  INDICATOR_DATA);
   SetIndexBuffer(17, g_M30Slow, INDICATOR_DATA);
   SetIndexBuffer(18, g_M15Fast, INDICATOR_DATA);
   SetIndexBuffer(19, g_M15Med,  INDICATOR_DATA);
   SetIndexBuffer(20, g_M15Slow, INDICATOR_DATA);
   SetIndexBuffer(21, g_M5Fast,  INDICATOR_DATA);
   SetIndexBuffer(22, g_M5Med,   INDICATOR_DATA);
   SetIndexBuffer(23, g_M5Slow,  INDICATOR_DATA);
   SetIndexBuffer(24, g_M1Fast,  INDICATOR_DATA);
   SetIndexBuffer(25, g_M1Med,   INDICATOR_DATA);
   SetIndexBuffer(26, g_M1Slow,  INDICATOR_DATA);

   //--- Common plot settings
   for(int i = 0; i < 27; i++)
   {
      PlotIndexSetDouble(i,  PLOT_EMPTY_VALUE, EMPTY_VALUE);
      PlotIndexSetInteger(i, PLOT_DRAW_BEGIN,  InpSlowPeriod);
   }

   //--- Update plot labels to reflect configured periods
   for(int tf = 0; tf < TF_COUNT; tf++)
   {
      int base = PlotBaseByIndex(tf);
      PlotIndexSetString(base,     PLOT_LABEL, MASpeedLabel(0) + " " + TfLabelByIndex(tf));
      PlotIndexSetString(base + 1, PLOT_LABEL, MASpeedLabel(1) + " " + TfLabelByIndex(tf));
      PlotIndexSetString(base + 2, PLOT_LABEL, MASpeedLabel(2) + " " + TfLabelByIndex(tf));
   }

   //--- Create MA handles
   for(int tf = 0; tf < TF_COUNT; tf++)
   {
      ENUM_TIMEFRAMES period = TFByIndex(tf);
      g_Hnd[tf][0] = iMA(_Symbol, period, InpFastPeriod, InpMAShift, InpMAMethod, InpMAPrice);
      g_Hnd[tf][1] = iMA(_Symbol, period, InpMedPeriod,  InpMAShift, InpMAMethod, InpMAPrice);
      g_Hnd[tf][2] = iMA(_Symbol, period, InpSlowPeriod, InpMAShift, InpMAMethod, InpMAPrice);

      if(g_Hnd[tf][0] == INVALID_HANDLE ||
         g_Hnd[tf][1] == INVALID_HANDLE ||
         g_Hnd[tf][2] == INVALID_HANDLE)
      {
         Print("[TripleMA MTF] ERROR: failed to create MA handles for ", TfLabelByIndex(tf));
         return INIT_FAILED;
      }
   }

   //--- Eligibility: only show TFs >= chart period
   int chartSecs = PeriodSeconds(Period());
   g_EligibleMN1 = chartSecs <= PeriodSeconds(PERIOD_MN1);
   g_EligibleW1  = chartSecs <= PeriodSeconds(PERIOD_W1);
   g_EligibleD1  = chartSecs <= PeriodSeconds(PERIOD_D1);
   g_EligibleH4  = chartSecs <= PeriodSeconds(PERIOD_H4);
   g_EligibleH1  = chartSecs <= PeriodSeconds(PERIOD_H1);
   g_EligibleM30 = chartSecs <= PeriodSeconds(PERIOD_M30);
   g_EligibleM15 = chartSecs <= PeriodSeconds(PERIOD_M15);
   g_EligibleM5  = chartSecs <= PeriodSeconds(PERIOD_M5);
   g_EligibleM1  = chartSecs <= PeriodSeconds(PERIOD_M1);

   IndicatorSetString(INDICATOR_SHORTNAME,
      StringFormat("Triple MA MTF (%d/%d/%d %s)",
                   InpFastPeriod, InpMedPeriod, InpSlowPeriod,
                   EnumToString(InpMAMethod)));

   g_LastBarTime = 0;
   g_LastMN1Time = 0; g_LastW1Time  = 0; g_LastD1Time  = 0;
   g_LastH4Time  = 0; g_LastH1Time  = 0; g_LastM30Time = 0;
   g_LastM15Time = 0; g_LastM5Time  = 0; g_LastM1Time  = 0;

   Panel_Create();
   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Deinit                                                            |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   ChartSetInteger(0, CHART_MOUSE_SCROLL, true);
   Panel_Delete();

   if(reason == REASON_REMOVE || reason == REASON_RECOMPILE)
      State_Delete();

   for(int tf = 0; tf < TF_COUNT; tf++)
      for(int ma = 0; ma < 3; ma++)
         if(g_Hnd[tf][ma] != INVALID_HANDLE)
            IndicatorRelease(g_Hnd[tf][ma]);

   ChartRedraw(0);
}

//+------------------------------------------------------------------+
//| Calculation                                                       |
//+------------------------------------------------------------------+
int OnCalculate(const int       rates_total,
                const int       prev_calculated,
                const datetime &time[],
                const double   &open[],
                const double   &high[],
                const double   &low[],
                const double   &close[],
                const long     &tick_volume[],
                const long     &volume[],
                const int      &spread[])
{
   g_RatesTotal = rates_total;
   ArrayCopy(g_Time, time);

   if(rates_total < InpSlowPeriod)
      return 0;

   //--- Detect new bars at each timeframe
   datetime curMN1 = iTime(_Symbol, PERIOD_MN1, 0);
   datetime curW1  = iTime(_Symbol, PERIOD_W1,  0);
   datetime curD1  = iTime(_Symbol, PERIOD_D1,  0);
   datetime curH4  = iTime(_Symbol, PERIOD_H4,  0);
   datetime curH1  = iTime(_Symbol, PERIOD_H1,  0);
   datetime curM30 = iTime(_Symbol, PERIOD_M30, 0);
   datetime curM15 = iTime(_Symbol, PERIOD_M15, 0);
   datetime curM5  = iTime(_Symbol, PERIOD_M5,  0);
   datetime curM1  = iTime(_Symbol, PERIOD_M1,  0);

   bool newBar    = (time[rates_total - 1] != g_LastBarTime);
   bool newMN1    = (curMN1 != g_LastMN1Time);
   bool newW1     = (curW1  != g_LastW1Time);
   bool newD1     = (curD1  != g_LastD1Time);
   bool newH4     = (curH4  != g_LastH4Time);
   bool newH1     = (curH1  != g_LastH1Time);
   bool newM30    = (curM30 != g_LastM30Time);
   bool newM15    = (curM15 != g_LastM15Time);
   bool newM5     = (curM5  != g_LastM5Time);
   bool newM1     = (curM1  != g_LastM1Time);

   //--- Effective (show + eligible)
   bool effMN1 = g_ShowMN1 && g_EligibleMN1;
   bool effW1  = g_ShowW1  && g_EligibleW1;
   bool effD1  = g_ShowD1  && g_EligibleD1;
   bool effH4  = g_ShowH4  && g_EligibleH4;
   bool effH1  = g_ShowH1  && g_EligibleH1;
   bool effM30 = g_ShowM30 && g_EligibleM30;
   bool effM15 = g_ShowM15 && g_EligibleM15;
   bool effM5  = g_ShowM5  && g_EligibleM5;
   bool effM1  = g_ShowM1  && g_EligibleM1;

   //--- Force full refill when a TF was just re-enabled
   bool forceMN1 = effMN1 && !g_PrevShowMN1;
   bool forceW1  = effW1  && !g_PrevShowW1;
   bool forceD1  = effD1  && !g_PrevShowD1;
   bool forceH4  = effH4  && !g_PrevShowH4;
   bool forceH1  = effH1  && !g_PrevShowH1;
   bool forceM30 = effM30 && !g_PrevShowM30;
   bool forceM15 = effM15 && !g_PrevShowM15;
   bool forceM5  = effM5  && !g_PrevShowM5;
   bool forceM1  = effM1  && !g_PrevShowM1;

   g_PrevShowMN1 = effMN1;  g_PrevShowW1  = effW1;   g_PrevShowD1  = effD1;
   g_PrevShowH4  = effH4;   g_PrevShowH1  = effH1;   g_PrevShowM30 = effM30;
   g_PrevShowM15 = effM15;  g_PrevShowM5  = effM5;   g_PrevShowM1  = effM1;

   //--- Skip if nothing changed
   if(prev_calculated > 0 &&
      !newBar  && !newMN1  && !newW1   && !newD1   && !newH4  &&
      !newH1   && !newM30  && !newM15  && !newM5   && !newM1  &&
      !forceMN1 && !forceW1 && !forceD1 && !forceH4 && !forceH1 &&
      !forceM30 && !forceM15 && !forceM5 && !forceM1)
      return rates_total;

   //--- Wait for handles to have data
   if((effMN1 && !TFHandlesReady(TF_MN1)) ||
      (effW1  && !TFHandlesReady(TF_W1))  ||
      (effD1  && !TFHandlesReady(TF_D1))  ||
      (effH4  && !TFHandlesReady(TF_H4))  ||
      (effH1  && !TFHandlesReady(TF_H1))  ||
      (effM30 && !TFHandlesReady(TF_M30)) ||
      (effM15 && !TFHandlesReady(TF_M15)) ||
      (effM5  && !TFHandlesReady(TF_M5))  ||
      (effM1  && !TFHandlesReady(TF_M1)))
      return 0;

   //--- Update timestamps
   g_LastBarTime = time[rates_total - 1];
   g_LastMN1Time = curMN1;  g_LastW1Time  = curW1;   g_LastD1Time  = curD1;
   g_LastH4Time  = curH4;   g_LastH1Time  = curH1;   g_LastM30Time = curM30;
   g_LastM15Time = curM15;  g_LastM5Time  = curM5;   g_LastM1Time  = curM1;

   int baseStart = (prev_calculated == 0) ? 0 : MathMax(0, prev_calculated - 2);

   int startMN1 = (forceMN1 || prev_calculated == 0) ? 0 : baseStart;
   int startW1  = (forceW1  || prev_calculated == 0) ? 0 : baseStart;
   int startD1  = (forceD1  || prev_calculated == 0) ? 0 : baseStart;
   int startH4  = (forceH4  || prev_calculated == 0) ? 0 : baseStart;
   int startH1  = (forceH1  || prev_calculated == 0) ? 0 : baseStart;
   int startM30 = (forceM30 || prev_calculated == 0) ? 0 : baseStart;
   int startM15 = (forceM15 || prev_calculated == 0) ? 0 : baseStart;
   int startM5  = (forceM5  || prev_calculated == 0) ? 0 : baseStart;
   int startM1  = (forceM1  || prev_calculated == 0) ? 0 : baseStart;

   if(effMN1) FillTFMAs(TF_MN1, startMN1, rates_total, time, g_MN1Fast, g_MN1Med, g_MN1Slow);
   else if(prev_calculated == 0) ClearMA(g_MN1Fast, g_MN1Med, g_MN1Slow);

   if(effW1)  FillTFMAs(TF_W1,  startW1,  rates_total, time, g_W1Fast,  g_W1Med,  g_W1Slow);
   else if(prev_calculated == 0) ClearMA(g_W1Fast,  g_W1Med,  g_W1Slow);

   if(effD1)  FillTFMAs(TF_D1,  startD1,  rates_total, time, g_D1Fast,  g_D1Med,  g_D1Slow);
   else if(prev_calculated == 0) ClearMA(g_D1Fast,  g_D1Med,  g_D1Slow);

   if(effH4)  FillTFMAs(TF_H4,  startH4,  rates_total, time, g_H4Fast,  g_H4Med,  g_H4Slow);
   else if(prev_calculated == 0) ClearMA(g_H4Fast,  g_H4Med,  g_H4Slow);

   if(effH1)  FillTFMAs(TF_H1,  startH1,  rates_total, time, g_H1Fast,  g_H1Med,  g_H1Slow);
   else if(prev_calculated == 0) ClearMA(g_H1Fast,  g_H1Med,  g_H1Slow);

   if(effM30) FillTFMAs(TF_M30, startM30, rates_total, time, g_M30Fast, g_M30Med, g_M30Slow);
   else if(prev_calculated == 0) ClearMA(g_M30Fast, g_M30Med, g_M30Slow);

   if(effM15) FillTFMAs(TF_M15, startM15, rates_total, time, g_M15Fast, g_M15Med, g_M15Slow);
   else if(prev_calculated == 0) ClearMA(g_M15Fast, g_M15Med, g_M15Slow);

   if(effM5)  FillTFMAs(TF_M5,  startM5,  rates_total, time, g_M5Fast,  g_M5Med,  g_M5Slow);
   else if(prev_calculated == 0) ClearMA(g_M5Fast,  g_M5Med,  g_M5Slow);

   if(effM1)  FillTFMAs(TF_M1,  startM1,  rates_total, time, g_M1Fast,  g_M1Med,  g_M1Slow);
   else if(prev_calculated == 0) ClearMA(g_M1Fast,  g_M1Med,  g_M1Slow);

   Labels_Refresh();
   return rates_total;
}

//+------------------------------------------------------------------+
//| Chart events                                                      |
//+------------------------------------------------------------------+
void OnChartEvent(const int id, const long &lparam,
                  const double &dparam, const string &sparam)
{
   //--- Mouse move: handle drag
   if(id == CHARTEVENT_MOUSE_MOVE)
   {
      int  mouseX = (int)lparam;
      int  mouseY = (int)dparam;
      bool lbDown = ((int)StringToInteger(sparam) & 1) != 0;

      if(lbDown && !g_WasLBDown)
      {
         bool overTitle = mouseX >= g_PanelX + PADDING &&
                          mouseX <= g_PanelX + PANEL_W - PADDING &&
                          mouseY >= g_PanelY + PADDING &&
                          mouseY <= g_PanelY + PADDING + TOGGLE_H;
         if(overTitle)
         {
            g_Dragging        = true;
            g_ActuallyDragged = false;
            g_DragOffX        = mouseX - g_PanelX;
            g_DragOffY        = mouseY - g_PanelY;
            g_DragStartX      = mouseX;
            g_DragStartY      = mouseY;
            ChartSetInteger(0, CHART_MOUSE_SCROLL, false);
         }
      }

      if(!lbDown && g_Dragging)
      {
         g_Dragging = false;
         ChartSetInteger(0, CHART_MOUSE_SCROLL, true);
      }

      if(g_Dragging && lbDown)
      {
         int dx = mouseX - g_DragStartX;
         int dy = mouseY - g_DragStartY;
         if(!g_ActuallyDragged &&
            (MathAbs(dx) > DRAG_THRESHOLD || MathAbs(dy) > DRAG_THRESHOLD))
            g_ActuallyDragged = true;

         if(g_ActuallyDragged)
            Panel_Move(mouseX - g_DragOffX, mouseY - g_DragOffY);
      }

      g_WasLBDown = lbDown;
      return;
   }

   if(id != CHARTEVENT_OBJECT_CLICK)
      return;

   //--- Toggle panel expand/collapse
   if(sparam == N("Toggle"))
   {
      ObjectSetInteger(0, N("Toggle"), OBJPROP_STATE, false);
      if(g_ActuallyDragged) { g_ActuallyDragged = false; return; }
      Panel_SetExpanded(!g_Expanded);
      return;
   }

   //--- Timeframe checkboxes
   if(sparam == N("CbMN1"))
   {
      ToggleTF("CbMN1", g_ShowMN1, g_EligibleMN1, g_PrevShowMN1,
               clrMagenta, TF_MN1, g_MN1Fast, g_MN1Med, g_MN1Slow);
      return;
   }
   if(sparam == N("CbW1"))
   {
      ToggleTF("CbW1", g_ShowW1, g_EligibleW1, g_PrevShowW1,
               clrDodgerBlue, TF_W1, g_W1Fast, g_W1Med, g_W1Slow);
      return;
   }
   if(sparam == N("CbD1"))
   {
      ToggleTF("CbD1", g_ShowD1, g_EligibleD1, g_PrevShowD1,
               clrOrange, TF_D1, g_D1Fast, g_D1Med, g_D1Slow);
      return;
   }
   if(sparam == N("CbH4"))
   {
      ToggleTF("CbH4", g_ShowH4, g_EligibleH4, g_PrevShowH4,
               clrLimeGreen, TF_H4, g_H4Fast, g_H4Med, g_H4Slow);
      return;
   }
   if(sparam == N("CbH1"))
   {
      ToggleTF("CbH1", g_ShowH1, g_EligibleH1, g_PrevShowH1,
               clrGold, TF_H1, g_H1Fast, g_H1Med, g_H1Slow);
      return;
   }
   if(sparam == N("CbM30"))
   {
      ToggleTF("CbM30", g_ShowM30, g_EligibleM30, g_PrevShowM30,
               clrTomato, TF_M30, g_M30Fast, g_M30Med, g_M30Slow);
      return;
   }
   if(sparam == N("CbM15"))
   {
      ToggleTF("CbM15", g_ShowM15, g_EligibleM15, g_PrevShowM15,
               clrDeepSkyBlue, TF_M15, g_M15Fast, g_M15Med, g_M15Slow);
      return;
   }
   if(sparam == N("CbM5"))
   {
      ToggleTF("CbM5", g_ShowM5, g_EligibleM5, g_PrevShowM5,
               clrViolet, TF_M5, g_M5Fast, g_M5Med, g_M5Slow);
      return;
   }
   if(sparam == N("CbM1"))
   {
      ToggleTF("CbM1", g_ShowM1, g_EligibleM1, g_PrevShowM1,
               clrSilver, TF_M1, g_M1Fast, g_M1Med, g_M1Slow);
      return;
   }
}
//+------------------------------------------------------------------+
