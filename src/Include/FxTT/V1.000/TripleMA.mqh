//+------------------------------------------------------------------+
//|                                                   TripleMA.mqh   |
//|                                                             FxTT  |
//| Reusable Triple Moving Average (fast / med / slow) for one TF.   |
//|                                                                    |
//| Quick-start (single TF):                                          |
//|   #include <FxTT/V1.000/TripleMA.mqh>                            |
//|   CTripleMA g_TMA;                                                |
//|   double    g_Fast[], g_Med[], g_Slow[];                          |
//|                                                                    |
//|   OnInit()   → g_TMA.Init(PERIOD_D1, 50,100,200, 0,              |
//|                            MODE_EMA, PRICE_CLOSE)                 |
//|   OnCalculate() → if(g_TMA.IsReady())                            |
//|                      g_TMA.Fill(g_Fast,g_Med,g_Slow,             |
//|                                 start, total, time);              |
//|   OnDeinit()  → g_TMA.Deinit()                                   |
//|                                                                    |
//| IMPORTANT: time[] passed to Fill() must NOT be set as series      |
//|   (index 0 = oldest bar, as received from OnCalculate).          |
//|   The first (slowPer-1) bars may still be EMPTY_VALUE.           |
//| NOTE: Fill leaves all destinations untouched when source data is  |
//|   unavailable or incomplete.                                     |
//| NOTE: CTripleMA is non-copyable. Do not assign between instances  |
//|   or place in arrays — handle aliasing causes double-release.    |
//+------------------------------------------------------------------+
#ifndef TRIPLE_MA_MQH
#define TRIPLE_MA_MQH

#property copyright "FxTT"
#property strict

//--- Total standard timeframes in the preset set (MN1 … M1)
#define TRIPLE_MA_TF_COUNT 9

//+------------------------------------------------------------------+
//| TF index utilities (prefixed to avoid global name collisions)     |
//+------------------------------------------------------------------+

//--- Convert a sequential index (0 = MN1 … 8 = M1) to ENUM_TIMEFRAMES
ENUM_TIMEFRAMES TripleMA_TFByIndex(int index)
{
   switch(index)
   {
      case 0: return PERIOD_MN1;
      case 1: return PERIOD_W1;
      case 2: return PERIOD_D1;
      case 3: return PERIOD_H4;
      case 4: return PERIOD_H1;
      case 5: return PERIOD_M30;
      case 6: return PERIOD_M15;
      case 7: return PERIOD_M5;
      case 8: return PERIOD_M1;
   }
   return PERIOD_CURRENT;
}

//--- Short display label for a TF index
string TripleMA_TfLabelByIndex(int index)
{
   switch(index)
   {
      case 0: return "MN1";
      case 1: return "W1";
      case 2: return "D1";
      case 3: return "H4";
      case 4: return "H1";
      case 5: return "M30";
      case 6: return "M15";
      case 7: return "M5";
      case 8: return "M1";
   }
   return "";
}

//+------------------------------------------------------------------+
//| Convenience struct — groups one TF's three indicator buffers      |
//| Register with SetIndexBuffer(base+0/1/2, buf.Fast/Med/Slow).     |
//+------------------------------------------------------------------+
struct STFBuffers
{
   double Fast[];
   double Med[];
   double Slow[];
};

//+------------------------------------------------------------------+
//| CTripleMA — manages three iMA handles for a single timeframe     |
//|                                                                    |
//| Non-copyable: do not assign between instances or store in arrays. |
//+------------------------------------------------------------------+
class CTripleMA
{
private:
   int             m_hnd[3];   // [0]=fast  [1]=med  [2]=slow
   ENUM_TIMEFRAMES m_tf;
   string          m_symbol;   // symbol the handles were created for

public:
                   CTripleMA();

   //--- Create iMA handles. Releases any existing handles first.
   //--- symbol: target symbol; pass "" or omit to use _Symbol.
   //--- Returns false on failure.
   bool            Init(ENUM_TIMEFRAMES    tf,
                        int                fastPer,
                        int                medPer,
                        int                slowPer,
                        int                shift,
                        ENUM_MA_METHOD     method,
                        ENUM_APPLIED_PRICE price,
                        string             symbol = "");

   //--- Release handles. Safe to call multiple times.
   void            Deinit();

   //--- True once all three handles have calculated at least one bar.
   //--- Note: the first (slowPer-1) bars may still return EMPTY_VALUE.
   bool            IsReady() const;

   //--- Fill fast/med/slow buffers from [start, total).
   //--- time[] and destination buffers use index 0 = oldest bar.
   bool            Fill(double &fast[], double &med[], double &slow[],
                        int start, int total, const datetime &time[]);

   //--- Overload for STFBuffers convenience struct.
   bool            Fill(STFBuffers &buf, int start, int total,
                        const datetime &time[]);

   //--- Set all buffer elements to EMPTY_VALUE.
   static void     Clear(double &fast[], double &med[], double &slow[]);
   static void     Clear(STFBuffers &buf);

   ENUM_TIMEFRAMES TF()     const { return m_tf;     }
   string          Symbol() const { return m_symbol; }
};

//--- Constructor
CTripleMA::CTripleMA()
{
   m_hnd[0] = m_hnd[1] = m_hnd[2] = INVALID_HANDLE;
   m_tf     = PERIOD_CURRENT;
   m_symbol = "";
}

//--- Init
bool CTripleMA::Init(ENUM_TIMEFRAMES    tf,
                     int                fastPer,
                     int                medPer,
                     int                slowPer,
                     int                shift,
                     ENUM_MA_METHOD     method,
                     ENUM_APPLIED_PRICE price,
                     string             symbol)
{
   Deinit();  // release any existing handles before re-initialising

   m_symbol = (symbol == "") ? _Symbol : symbol;
   m_tf     = tf;
   m_hnd[0] = iMA(m_symbol, tf, fastPer, shift, method, price);
   m_hnd[1] = iMA(m_symbol, tf, medPer,  shift, method, price);
   m_hnd[2] = iMA(m_symbol, tf, slowPer, shift, method, price);

   if(m_hnd[0] == INVALID_HANDLE ||
      m_hnd[1] == INVALID_HANDLE ||
      m_hnd[2] == INVALID_HANDLE)
   {
      Print("[CTripleMA] Failed to create handles for ",
            EnumToString(tf), " on ", m_symbol);
      Deinit();
      return false;
   }
   return true;
}

//--- Deinit
void CTripleMA::Deinit()
{
   for(int i = 0; i < 3; i++)
      if(m_hnd[i] != INVALID_HANDLE)
      {
         IndicatorRelease(m_hnd[i]);
         m_hnd[i] = INVALID_HANDLE;
      }
}

//--- IsReady
bool CTripleMA::IsReady() const
{
   return BarsCalculated(m_hnd[0]) > 0 &&
          BarsCalculated(m_hnd[1]) > 0 &&
          BarsCalculated(m_hnd[2]) > 0;
}

//--- Fill (individual arrays)
bool CTripleMA::Fill(double &fast[], double &med[], double &slow[],
                     int start, int total, const datetime &time[])
{
   if(start >= total)
      return true;
   if(ArrayGetAsSeries(time) || ArrayGetAsSeries(fast) ||
      ArrayGetAsSeries(med) || ArrayGetAsSeries(slow) ||
      ArraySize(time) < total || ArraySize(fast) < total ||
      ArraySize(med) < total || ArraySize(slow) < total)
      return false;

   int requiredBars = Bars(m_symbol, m_tf, time[start], TimeCurrent());
   int barsNeeded = requiredBars + 2;
   if(barsNeeded <= 0)
      barsNeeded = Bars(m_symbol, m_tf);
   if(barsNeeded <= 0)
      return false;

   double fastSrc[], medSrc[], slowSrc[];
   datetime htfTime[];
   ArraySetAsSeries(fastSrc, false);
   ArraySetAsSeries(medSrc, false);
   ArraySetAsSeries(slowSrc, false);
   ArraySetAsSeries(htfTime, false);
   int copiedTime = CopyTime(m_symbol, m_tf, 0, barsNeeded, htfTime);
   int copiedFast = CopyBuffer(m_hnd[0], 0, 0, barsNeeded, fastSrc);
   int copiedMed  = CopyBuffer(m_hnd[1], 0, 0, barsNeeded, medSrc);
   int copiedSlow = CopyBuffer(m_hnd[2], 0, 0, barsNeeded, slowSrc);
   if(copiedTime <= 0 || copiedFast != copiedTime ||
      copiedMed != copiedTime || copiedSlow != copiedTime)
      return false;
   if(requiredBars > 0 && copiedTime < requiredBars)
      return false;
   int sourceShift = iBarShift(m_symbol, m_tf, time[total - 1], false);
   if(sourceShift < 0 || copiedTime <= sourceShift ||
      htfTime[copiedTime - 1] != iTime(m_symbol, m_tf, 0))
      return false;

   int j = 0;
   for(int i = start; i < total; i++)
   {
      while(j < copiedTime - 1 && htfTime[j + 1] <= time[i])
         j++;
      fast[i] = (htfTime[j] <= time[i]) ? fastSrc[j] : EMPTY_VALUE;
      med[i]  = (htfTime[j] <= time[i]) ? medSrc[j]  : EMPTY_VALUE;
      slow[i] = (htfTime[j] <= time[i]) ? slowSrc[j] : EMPTY_VALUE;
   }
   return true;
}

//--- Fill (STFBuffers overload)
bool CTripleMA::Fill(STFBuffers &buf, int start, int total,
                     const datetime &time[])
{
   return Fill(buf.Fast, buf.Med, buf.Slow, start, total, time);
}

//--- Clear (individual arrays)
void CTripleMA::Clear(double &fast[], double &med[], double &slow[])
{
   ArrayInitialize(fast, EMPTY_VALUE);
   ArrayInitialize(med,  EMPTY_VALUE);
   ArrayInitialize(slow, EMPTY_VALUE);
}

//--- Clear (STFBuffers overload)
void CTripleMA::Clear(STFBuffers &buf)
{
   ArrayInitialize(buf.Fast, EMPTY_VALUE);
   ArrayInitialize(buf.Med,  EMPTY_VALUE);
   ArrayInitialize(buf.Slow, EMPTY_VALUE);
}


#endif // TRIPLE_MA_MQH
