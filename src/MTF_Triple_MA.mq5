//+------------------------------------------------------------------+
//|                                             MTF_Triple_MA.mq5    |
//|                                                             FxTT  |
//+------------------------------------------------------------------+
#property copyright "FxTT"
#property link      ""
#property version   "2.00"
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

#include <FxTT/V1.000/TripleMA.mqh>

//+------------------------------------------------------------------+
//| Inputs                                                            |
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
#define TF_COUNT TRIPLE_MA_TF_COUNT

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
//| Indicator buffers — 9 TFs × 3 MAs = 27                           |
//| Declared as struct members so loops can index them uniformly.     |
//+------------------------------------------------------------------+
STFBuffers g_Buf[TF_COUNT];

//+------------------------------------------------------------------+
//| Triple MA instances — one per timeframe                           |
//+------------------------------------------------------------------+
CTripleMA g_TMA[TF_COUNT];

//+------------------------------------------------------------------+
//| Per-TF state arrays (replaces 9 × 3 individual variables)        |
//+------------------------------------------------------------------+
bool     g_Show[TF_COUNT];
bool     g_Eligible[TF_COUNT];
bool     g_PrevShow[TF_COUNT];
datetime g_LastTFTime[TF_COUNT];

//+------------------------------------------------------------------+
//| New-bar detection for chart timeframe                             |
//+------------------------------------------------------------------+
datetime g_LastBarTime = 0;

//+------------------------------------------------------------------+
//| Cached chart time array                                           |
//+------------------------------------------------------------------+
int      g_RatesTotal = 0;
datetime g_Time[];

//+------------------------------------------------------------------+
//| Panel / visibility state                                          |
//+------------------------------------------------------------------+
bool g_Expanded = true;

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
//| UI helpers                                                        |
//+------------------------------------------------------------------+
string N(const string name)      { return g_Pfx + name; }
int    PlotBaseByIndex(int index) { return index * 3; }

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

color AccentColorByIndex(int index)
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

string CheckboxIdByIndex(int index)
{
   return "Cb" + TripleMA_TfLabelByIndex(index);
}

string CheckboxLabelByIndex(int index)
{
   return "■  Triple MA  " + TripleMA_TfLabelByIndex(index);
}

string MASpeedLabel(int maIndex)
{
   switch(maIndex)
   {
      case 0: return StringFormat("MA%d", InpFastPeriod);
      case 1: return StringFormat("MA%d", InpMedPeriod);
      case 2: return StringFormat("MA%d", InpSlowPeriod);
   }
   return "";
}

string PlotLabel(int plotIndex)
{
   return MASpeedLabel(plotIndex % 3) + " " + TripleMA_TfLabelByIndex(plotIndex / 3);
}

//+------------------------------------------------------------------+
//| State persistence                                                 |
//+------------------------------------------------------------------+
void State_Save()
{
   GlobalVariableSet(GVK("X"),        g_PanelX);
   GlobalVariableSet(GVK("Y"),        g_PanelY);
   GlobalVariableSet(GVK("Expanded"), g_Expanded ? 1.0 : 0.0);
   for(int i = 0; i < TF_COUNT; i++)
      GlobalVariableSet(GVK("Show" + TripleMA_TfLabelByIndex(i)), g_Show[i] ? 1.0 : 0.0);
}

bool State_Load()
{
   if(!GlobalVariableCheck(GVK("X")))
      return false;

   g_PanelX   = (int)GlobalVariableGet(GVK("X"));
   g_PanelY   = (int)GlobalVariableGet(GVK("Y"));
   g_Expanded = GlobalVariableGet(GVK("Expanded")) != 0.0;

   for(int i = 0; i < TF_COUNT; i++)
   {
      string key = GVK("Show" + TripleMA_TfLabelByIndex(i));
      if(GlobalVariableCheck(key))
         g_Show[i] = GlobalVariableGet(key) != 0.0;
   }
   return true;
}

void State_Delete()
{
   GlobalVariableDel(GVK("X"));
   GlobalVariableDel(GVK("Y"));
   GlobalVariableDel(GVK("Expanded"));
   for(int i = 0; i < TF_COUNT; i++)
      GlobalVariableDel(GVK("Show" + TripleMA_TfLabelByIndex(i)));
}

//+------------------------------------------------------------------+
//| Label objects                                                     |
//+------------------------------------------------------------------+
int SecondsPerCurrentBar()
{
   int s = PeriodSeconds(Period());
   return (s > 0) ? s : 60;
}

void DeleteMALabel(int plotIndex)
{
   ObjectDelete(0, N("MALbl_" + IntegerToString(plotIndex)));
}

void SetMALabel(int plotIndex, bool visible,
                datetime baseTime, double price, int barSeconds)
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

void SetTFLabels(int tfIndex, bool visible,
                 datetime baseTime, int barSeconds,
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
   SetMALabel(base,     true, baseTime, fast[last], barSeconds);
   SetMALabel(base + 1, true, baseTime, med[last],  barSeconds);
   SetMALabel(base + 2, true, baseTime, slow[last], barSeconds);
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
   for(int i = 0; i < TF_COUNT; i++)
      SetTFLabels(i, g_Show[i] && g_Eligible[i], baseTime, bsecs,
                  g_Buf[i].Fast, g_Buf[i].Med, g_Buf[i].Slow);
}

//+------------------------------------------------------------------+
//| Low-level panel object builders                                   |
//+------------------------------------------------------------------+
void _CreateBackground(const string name, int x, int y, int w, int h)
{
   if(ObjectFind(0, name) < 0)
      ObjectCreate(0, name, OBJ_RECTANGLE_LABEL, 0, 0, 0);

   ObjectSetInteger(0, name, OBJPROP_XDISTANCE,  x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE,  y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE,      w);
   ObjectSetInteger(0, name, OBJPROP_YSIZE,      h);
   ObjectSetInteger(0, name, OBJPROP_CORNER,     CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR,    CLR_PANEL_BG);
   ObjectSetInteger(0, name, OBJPROP_BORDER_TYPE,BORDER_FLAT);
   ObjectSetInteger(0, name, OBJPROP_COLOR,      CLR_PANEL_BORDER);
   ObjectSetInteger(0, name, OBJPROP_WIDTH,      1);
   ObjectSetInteger(0, name, OBJPROP_BACK,       false);
   ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, name, OBJPROP_HIDDEN,     true);
   ObjectSetInteger(0, name, OBJPROP_ZORDER,     1);
}

void _CreateButton(const string name, int x, int y, int w, int h,
                   const string text, color bg, color fg,
                   int fontsize = 9, bool state = false)
{
   if(ObjectFind(0, name) < 0)
      ObjectCreate(0, name, OBJ_BUTTON, 0, 0, 0);

   ObjectSetInteger(0, name, OBJPROP_XDISTANCE,   x);
   ObjectSetInteger(0, name, OBJPROP_YDISTANCE,   y);
   ObjectSetInteger(0, name, OBJPROP_XSIZE,        w);
   ObjectSetInteger(0, name, OBJPROP_YSIZE,        h);
   ObjectSetInteger(0, name, OBJPROP_CORNER,       CORNER_LEFT_UPPER);
   ObjectSetInteger(0, name, OBJPROP_BGCOLOR,      bg);
   ObjectSetInteger(0, name, OBJPROP_COLOR,        fg);
   ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, CLR_PANEL_BORDER);
   ObjectSetString(0,  name, OBJPROP_TEXT,         text);
   ObjectSetInteger(0, name, OBJPROP_FONTSIZE,     fontsize);
   ObjectSetString(0,  name, OBJPROP_FONT,         "Segoe UI");
   ObjectSetInteger(0, name, OBJPROP_STATE,        state);
   ObjectSetInteger(0, name, OBJPROP_SELECTABLE,   false);
   ObjectSetInteger(0, name, OBJPROP_HIDDEN,       true);
   ObjectSetInteger(0, name, OBJPROP_ZORDER,       10);
}

//+------------------------------------------------------------------+
//| Plot / buffer helpers                                             |
//+------------------------------------------------------------------+
void SetPlotVisibility(int plotBase, bool show)
{
   for(int j = 0; j < 3; j++)
      PlotIndexSetInteger(plotBase + j, PLOT_DRAW_TYPE, show ? DRAW_LINE : DRAW_NONE);
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

void ToggleTF(int tfIndex)
{
   string id      = CheckboxIdByIndex(tfIndex);
   bool   eligible = g_Eligible[tfIndex];

   if(!eligible)
   {
      ObjectSetInteger(0, N(id), OBJPROP_STATE, false);
      return;
   }

   g_Show[tfIndex] = (bool)ObjectGetInteger(0, N(id), OBJPROP_STATE);
   Panel_UpdateCheckbox(id, g_Show[tfIndex], AccentColorByIndex(tfIndex));
   SetPlotVisibility(PlotBaseByIndex(tfIndex), g_Show[tfIndex]);

   if(g_Show[tfIndex])
   {
      g_TMA[tfIndex].Fill(g_Buf[tfIndex], 0, g_RatesTotal, g_Time);
      g_PrevShow[tfIndex] = true;
   }
   else
      CTripleMA::Clear(g_Buf[tfIndex]);

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
      bool   eligible = g_Eligible[i];
      bool   showSt   = g_Show[i] && eligible;
      color  accent   = AccentColorByIndex(i);
      color  fg       = !eligible ? CLR_DISABLED_TEXT : (showSt ? accent : CLR_UNCHECKED_TEXT);
      color  bg       = !eligible ? CLR_DISABLED_BG   : (showSt ? CLR_CHECK_BG_ON : CLR_CHECK_BG_OFF);
      string id       = CheckboxIdByIndex(i);

      _CreateButton(N(id), bx, cy, bw, CHECK_H, CheckboxLabelByIndex(i), bg, fg, 9, showSt);
      ObjectSetInteger(0, N(id), OBJPROP_TIMEFRAMES, g_Expanded ? OBJ_ALL_PERIODS : OBJ_NO_PERIODS);
      cy += CHECK_H + GAP;
   }

   ObjectSetString(0, N("Toggle"), OBJPROP_TEXT,
                   g_Expanded ? " Triple MA Panel  ▲" : " Triple MA Panel  ▼");

   for(int i = 0; i < TF_COUNT; i++)
      SetPlotVisibility(PlotBaseByIndex(i), g_Show[i] && g_Eligible[i]);

   Labels_Refresh();
   ChartRedraw(0);
}

void Panel_Delete()
{
   ObjectDelete(0, N("BG"));
   ObjectDelete(0, N("Toggle"));
   for(int i = 0; i < TF_COUNT; i++)
      ObjectDelete(0, N(CheckboxIdByIndex(i)));
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
      ObjectSetInteger(0, N(CheckboxIdByIndex(i)), OBJPROP_XDISTANCE, bx);
      ObjectSetInteger(0, N(CheckboxIdByIndex(i)), OBJPROP_YDISTANCE, cy);
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

   //--- Default all show states on before trying to load persisted state
   ArrayInitialize(g_Show,    1);
   ArrayInitialize(g_PrevShow,1);
   ArrayInitialize(g_LastTFTime, 0);

   if(!State_Load())
   {
      g_PanelX = InpPanelX;
      g_PanelY = InpPanelY;
   }

   ChartSetInteger(0, CHART_EVENT_MOUSE_MOVE, true);

   //--- Register indicator buffers (9 TFs × 3 MAs)
   for(int tf = 0; tf < TF_COUNT; tf++)
   {
      int base = PlotBaseByIndex(tf);
      SetIndexBuffer(base + 0, g_Buf[tf].Fast, INDICATOR_DATA);
      SetIndexBuffer(base + 1, g_Buf[tf].Med,  INDICATOR_DATA);
      SetIndexBuffer(base + 2, g_Buf[tf].Slow, INDICATOR_DATA);
   }

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
      PlotIndexSetString(base,     PLOT_LABEL, MASpeedLabel(0) + " " + TripleMA_TfLabelByIndex(tf));
      PlotIndexSetString(base + 1, PLOT_LABEL, MASpeedLabel(1) + " " + TripleMA_TfLabelByIndex(tf));
      PlotIndexSetString(base + 2, PLOT_LABEL, MASpeedLabel(2) + " " + TripleMA_TfLabelByIndex(tf));
   }

   //--- Create MA handles
   for(int tf = 0; tf < TF_COUNT; tf++)
   {
      if(!g_TMA[tf].Init(TripleMA_TFByIndex(tf),
                         InpFastPeriod, InpMedPeriod, InpSlowPeriod,
                         InpMAShift, InpMAMethod, InpMAPrice))
         return INIT_FAILED;
   }

   //--- Eligibility: only show TFs >= chart period
   int chartSecs = PeriodSeconds(Period());
   for(int i = 0; i < TF_COUNT; i++)
      g_Eligible[i] = chartSecs <= PeriodSeconds(TripleMA_TFByIndex(i));

   IndicatorSetString(INDICATOR_SHORTNAME,
      StringFormat("Triple MA MTF (%d/%d/%d %s)",
                   InpFastPeriod, InpMedPeriod, InpSlowPeriod,
                   EnumToString(InpMAMethod)));

   g_LastBarTime = 0;

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
      g_TMA[tf].Deinit();

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

   //--- Detect new bar on each TF
   bool newBar = (time[rates_total - 1] != g_LastBarTime);
   bool newTF[TF_COUNT];
   bool eff[TF_COUNT];
   bool force[TF_COUNT];

   bool anyChanged = newBar;
   for(int i = 0; i < TF_COUNT; i++)
   {
      datetime curTime = iTime(_Symbol, TripleMA_TFByIndex(i), 0);
      newTF[i]  = (curTime != g_LastTFTime[i]);
      eff[i]    = g_Show[i] && g_Eligible[i];
      force[i]  = eff[i] && !g_PrevShow[i];
      g_PrevShow[i] = eff[i];

      if(newTF[i] || force[i]) anyChanged = true;
   }

   if(prev_calculated > 0 && !anyChanged)
      return rates_total;

   //--- Wait until all active handles have data
   for(int i = 0; i < TF_COUNT; i++)
      if(eff[i] && !g_TMA[i].IsReady())
         return 0;

   //--- Update timestamps
   g_LastBarTime = time[rates_total - 1];
   for(int i = 0; i < TF_COUNT; i++)
      g_LastTFTime[i] = iTime(_Symbol, TripleMA_TFByIndex(i), 0);

   int baseStart = (prev_calculated == 0) ? 0 : MathMax(0, prev_calculated - 2);

   for(int i = 0; i < TF_COUNT; i++)
   {
      if(eff[i])
      {
         int start = (force[i] || prev_calculated == 0) ? 0 : baseStart;
         g_TMA[i].Fill(g_Buf[i], start, rates_total, time);
      }
      else if(prev_calculated == 0)
         CTripleMA::Clear(g_Buf[i]);
   }

   Labels_Refresh();
   return rates_total;
}

//+------------------------------------------------------------------+
//| Chart events                                                      |
//+------------------------------------------------------------------+
void OnChartEvent(const int id, const long &lparam,
                  const double &dparam, const string &sparam)
{
   //--- Mouse move: drag panel
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

   //--- Toggle panel expand / collapse
   if(sparam == N("Toggle"))
   {
      ObjectSetInteger(0, N("Toggle"), OBJPROP_STATE, false);
      if(g_ActuallyDragged) { g_ActuallyDragged = false; return; }
      Panel_SetExpanded(!g_Expanded);
      return;
   }

   //--- Timeframe checkboxes
   for(int i = 0; i < TF_COUNT; i++)
   {
      if(sparam == N(CheckboxIdByIndex(i)))
      {
         ToggleTF(i);
         return;
      }
   }
}
//+------------------------------------------------------------------+
