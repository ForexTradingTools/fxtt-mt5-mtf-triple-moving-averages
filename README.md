# MTF Triple MA MT5 — Multi-Timeframe Moving Averages for MetaTrader 5

> **Free MT5 indicator.** Display Fast, Medium, and Slow moving averages from up to **9 timeframes simultaneously** on a single MetaTrader 5 chart — with a draggable control panel to toggle each timeframe instantly.

[![Platform](https://img.shields.io/badge/Platform-MetaTrader%205-blue)](#compatibility)
[![License](https://img.shields.io/badge/License-Free-brightgreen)](#license)
[![Version](https://img.shields.io/badge/Version-1.00-orange)](#changelog)
[![Instruments](https://img.shields.io/badge/Instruments-Forex%20%7C%20Gold%20%7C%20Indices%20%7C%20Crypto-lightgrey)](#compatibility)

---

![MTF Triple MA MT5 on a M5 chart](https://forextradingtools.eu/wp-content/uploads/2026/03/mtf-triple-ma-mt5-chart-m5-1024x705.png)

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Supported Timeframes](#supported-timeframes)
- [Installation](#installation)
- [Settings Reference](#settings-reference)
- [How to Use](#how-to-use)
- [Compatibility](#compatibility)
- [Changelog](#changelog)
- [Related Indicators](#related-indicators)
- [License](#license)

---

## Overview

**MTF Triple MA MT5** is a free multi-timeframe moving averages indicator for MetaTrader 5. It calculates three moving averages — **Fast**, **Medium**, and **Slow** — independently for each of up to nine timeframes, and projects all of them onto your active chart at once.

Instead of switching between chart windows to check higher-timeframe trend direction, you get the full market context on your execution chart. A draggable control panel lets you enable or disable any timeframe with a single click during live trading.

**Who it is for:** Traders who want to identify trend alignment, dynamic support and resistance levels, multi-timeframe MA confluence zones, and higher-timeframe trend context — without cluttering their workflow.

> **MT4 user?** See the [MTF Triple Moving Averages – MT4 version](https://forextradingtools.eu/products/indicators/mtf-triple-moving-averages-free-indicator/) on our website.

---

## Features

| Feature | Detail |
|---|---|
| **9 timeframes on one chart** | M1, M5, M15, M30, H1, H4, D1, W1, MN1 |
| **3 MAs per timeframe** | Fast, Medium, and Slow — independently configurable |
| **Color-coded by timeframe** | Each timeframe has its own colour scheme |
| **Line style by MA type** | Dotted (Fast) · Dashed (Medium) · Solid (Slow) |
| **Draggable control panel** | Move and collapse the panel freely on the chart |
| **One-click timeframe toggles** | Enable / disable any timeframe during live trading |
| **Auto lower-timeframe filtering** | Timeframes below the active chart are hidden automatically |
| **4 MA methods** | SMA, EMA, SMMA, LWMA — set independently per MA |
| **Applied price options** | Close, Open, High, Low, Median, Typical, Weighted |
| **No repainting** | Completed bar values are fixed and never change retroactively |
| **VPS compatible** | Runs persistently on a VPS; does not interfere with Expert Advisors |

---

## Supported Timeframes

| Timeframe | Label | Auto-disabled when… |
|---|---|---|
| Monthly | MN1 | Never |
| Weekly | W1 | Chart ≥ MN1 |
| Daily | D1 | Chart ≥ W1 |
| 4-Hour | H4 | Chart ≥ D1 |
| 1-Hour | H1 | Chart ≥ H4 |
| 30-Minute | M30 | Chart ≥ H1 |
| 15-Minute | M15 | Chart ≥ M30 |
| 5-Minute | M5 | Chart ≥ M15 |
| 1-Minute | M1 | Chart ≥ M5 |

Timeframes below your current chart timeframe are automatically disabled to keep the display relevant and reduce visual noise. You can re-enable them manually from the control panel at any time.

---

## Installation

### Requirements

- MetaTrader 5 (any build)
- Windows, macOS (via Wine/CrossOver), or VPS

### Steps

1. **Download** the `.zip` file from the [Releases](https://github.com/ForexTradingTools/fxtt-mt5-mtf-triple-moving-averages/releases) section or from the [product page](https://forextradingtools.eu).
2. **Extract** the zip — you will find `FxTT_MTF_TripleMA.ex5` inside.
3. In MetaTrader 5, go to **File → Open Data Folder**.
4. Navigate to **MQL5 → Indicators** and paste the `.ex5` file there.
5. Back in MT5, press **Ctrl+N** to open the Navigator panel, then right-click **Indicators → Refresh**.
6. Double-click the indicator in the Navigator, or drag it onto any chart to attach it.
7. Configure your settings in the Inputs tab and click OK.

### VPS Installation

Copy the `.ex5` file to the same `MQL5 → Indicators` path on your VPS instance of MT5. The indicator runs persistently even when your local computer is offline.

### Saving Your Settings as a Template

Once configured, right-click the chart → **Template → Save Template** to preserve your MA periods, colours, and timeframe preferences across sessions and chart changes.

### Updating to a New Version

1. Detach the indicator from any charts, or close those charts.
2. Replace the old `.ex5` file in `MQL5/Indicators` with the new one.
3. Restart MT5 or right-click → Refresh in the Navigator.
4. Re-attach the indicator — your saved templates will restore all previous settings.

### Troubleshooting

| Problem | Solution |
|---|---|
| Indicator not visible in Navigator after refresh | Confirm the file is in `MQL5/Indicators` (not a subfolder). Copy the `.ex5` file, not just the `.mq5` source. |
| No MA lines appear on the chart | Open the control panel and ensure at least one timeframe is enabled. Check that enabled timeframes are ≥ the current chart timeframe. |
| Lines disappear after changing chart timeframe | Expected behaviour — timeframes below the active chart are auto-hidden. Enable higher timeframes from the panel. |
| Panel not visible on chart | The panel may be outside the visible area. Reset its position via the Panel Corner / X-Y Offset inputs. |
| "Invalid ex5" error in MT5 | Re-download the file — the zip may have been corrupted. Open an issue if the problem persists. |

---

## Settings Reference

![Indicator settings](https://forextradingtools.eu/wp-content/uploads/2026/03/mtf-triple-ma-mt5-settings.png)

All parameters are in the **Inputs** tab of the indicator settings window. Open it by double-clicking the indicator in the Navigator, or right-clicking the chart → **Indicators List → Edit**.

### Moving Average Parameters

The same four parameters apply independently to the **Fast**, **Medium**, and **Slow** MA.

| Parameter | Default (Fast / Med / Slow) | Options | Notes |
|---|---|---|---|
| **Period** | 9 / 21 / 50 | Any integer ≥ 1 | Number of bars in the calculation. Applied per timeframe independently. |
| **Shift** | 0 | Any integer | Horizontal displacement in bars. Positive = shift right. |
| **Method** | EMA | SMA, EMA, SMMA, LWMA | See method guide below. |
| **Applied Price** | Close | Close, Open, High, Low, Median, Typical, Weighted | The price value fed into the MA calculation. |

### MA Method Guide

| Method | Responsiveness | Best Used For |
|---|---|---|
| **SMA** – Simple | Slowest | Clean, noise-free trend reading. Common for long-term structure (e.g. 200 SMA). |
| **EMA** – Exponential | Fast | Most popular in trading. Good default for all three MAs. |
| **SMMA** – Smoothed | Very slow | Very smooth; ideal as a slow trend filter. Effectively acts like a longer-period MA. |
| **LWMA** – Linear Weighted | Fastest | Maximum responsiveness. Best suited for the Fast MA only; can produce more whipsaws on others. |

### Control Panel Settings

| Parameter | Options | Description |
|---|---|---|
| **Panel Corner** | Top-Left, Top-Right, Bottom-Left, Bottom-Right | Starting anchor position of the panel. |
| **Panel X Offset** | Integer (pixels) | Horizontal distance from the selected corner. |
| **Panel Y Offset** | Integer (pixels) | Vertical distance from the selected corner. |
| **Panel Collapsed on Load** | true / false | Start with the panel minimised to save chart space. |

### Line Appearance Settings

For every combination of **MA type** (Fast / Medium / Slow) × **timeframe** (9 timeframes), you can individually configure:

- **Colour** — Each timeframe has a distinct default. Override any line to match your chart theme.
- **Width** — 1 to 5 pixels. Wider lines for higher timeframes improve readability.
- **Style** — Dotted (Fast), Dashed (Medium), Solid (Slow) by default. Keeping these conventions makes MA types easy to distinguish when timeframes overlap.

---

## How to Use

### Reading Trend Alignment

When Fast is **above** Medium and Medium is **above** Slow on a given timeframe → **bullish alignment** on that timeframe.
When the order is reversed → **bearish alignment**.

Look for the same alignment order across multiple timeframes simultaneously to identify strong trend confluence.

### Multi-Timeframe Trend Filter

1. Enable D1, H4, and H1 on the control panel.
2. Look for bullish alignment on all three timeframes simultaneously.
3. Drop to your execution timeframe (e.g. M15 or M5) and look for a long entry trigger.
4. Avoid longs when any enabled higher timeframe shows bearish MA order.

### Dynamic Support & Resistance

Higher-timeframe MAs frequently act as dynamic support in uptrends and resistance in downtrends. Watch for price approaching a D1 or W1 Slow MA level on your intraday chart — especially when it aligns with a recent swing level or another MA from a different timeframe.

### MA Confluence Zones

When Slow MAs from two or more timeframes cluster near the same price level, that zone carries more technical weight than a single MA in isolation. Enable H4 and D1 together and watch for convergence zones to form.

### Pullback Entries in Trending Markets

1. Confirm bullish trend on D1 (Fast > Medium > Slow).
2. Switch to H1 or M30.
3. Wait for price to pull back toward the H1 Fast or Medium MA.
4. Look for a reversal signal (pin bar, engulfing, MA recross) at that level.
5. Enter with a stop below the H1 Slow MA.

### Combining with Other Indicators

The MTF Triple MA works best as a **trend and structure tool**, not a standalone signal generator. Consider pairing it with:

- **[MTF Bollinger Bands MT5](https://forextradingtools.eu/products/indicators/mtf-bollinger-bands-mt5-indicator/)** — align trend direction (MAs) with volatility context (Bollinger Bands) on the same chart.
- **RSI or Stochastic** — use as a timing filter when price reaches a key MA level.
- **ATR** — confirm that a breakout or pullback is occurring with adequate volatility.

> **Note:** Moving averages are lagging indicators. Always combine them with price action context and a clear risk management plan. The indicator does not generate buy/sell signals — entry and exit decisions remain with the trader.

---

## Compatibility

| | |
|---|---|
| **Platform** | MetaTrader 5 (all builds) |
| **Operating System** | Windows · macOS (via Wine/CrossOver) · VPS |
| **Instruments** | Forex pairs · Gold (XAUUSD) · Indices (US30, NAS100, DE40…) · Crypto (BTCUSD, ETHUSD…) · All MT5-supported symbols |
| **Timeframes** | M1 to MN1 |
| **Expert Advisors** | Compatible — the indicator is visual only and does not interfere with EAs on the same or other charts |
| **MT4** | Not compatible — use the [MTF Triple MA MT4 version](https://forextradingtools.eu/products/indicators/mtf-triple-moving-averages-free-indicator/) instead |

---

## Changelog

| Version | Date | Notes |
|---|---|---|
| **1.00** | March 2026 | Initial release. 9 timeframes (M1–MN1), three MAs per timeframe (Fast/Medium/Slow), draggable control panel with one-click toggles, automatic lower-timeframe filtering, full MA customisation (period, shift, method, applied price, line style, width, colour). No repainting. |

**Update policy:** All updates are free. Replace the `.ex5` file in `MQL5/Indicators` with the new version and refresh the Navigator. Your saved templates preserve all custom settings across updates.

---

## Related Indicators

| Indicator | Platform | Description |
|---|---|---|
| [MTF Triple Moving Averages](https://forextradingtools.eu/products/indicators/mtf-triple-moving-averages-free-indicator/) | MT4 | The MT4 version of this indicator |
| [MTF Bollinger Bands MT5](https://forextradingtools.eu/products/indicators/mtf-bollinger-bands-mt5-indicator/) | MT5 | Multi-timeframe Bollinger Bands — pairs well with MTF Triple MA |

More free MT5 and MT4 indicators at [forextradingtools.eu](https://forextradingtools.eu).

---

## Related FxTT repositories

The public FxTT indicator family is split across these repositories:

- [FxTT MT4 Forex Scanner](https://github.com/ForexTradingTools/fxtt-mt4-forex-scanner)
- [FxTT MT5 Forex Scanner](https://github.com/ForexTradingTools/fxtt-mt5-forex-scanner)
- [FxTT Pivot Points MT5](https://github.com/ForexTradingTools/fxtt-mt5-pivot-points)
- [FxTT Session High/Low MT5](https://github.com/ForexTradingTools/fxtt-mt5-session-high-low)
- [FxTT News Calendar MT5](https://github.com/ForexTradingTools/fxtt-mt5-news-calendar)
- [FxTT ZigZag Zones MT5](https://github.com/ForexTradingTools/fxtt-mt5-zig-zag-zones)
- [FxTT MTF Bollinger Bands MT4](https://github.com/ForexTradingTools/fxtt-mt4-mtf-bollinger-bands)
- [FxTT MTF Bollinger Bands MT5](https://github.com/ForexTradingTools/fxtt-mt5-mtf-bollinger-bands)
- [FxTT MTF Triple MA MT4](https://github.com/ForexTradingTools/fxtt-mt4-mtf-triple-moving-averages)
- [FxTT Strategy Checklist MT4](https://github.com/ForexTradingTools/fxtt-mt4-strategy-checklist)
- [FxTT Strategy Checklist MT5](https://github.com/ForexTradingTools/fxtt-mt5-strategy-checklist)

## License

This indicator is provided **free of charge** for personal use. You may use it on any number of MT5 accounts and VPS instances. Redistribution, resale, or repackaging without written permission is not permitted.

© [Forex Trading Tools](https://forextradingtools.eu) — All rights reserved.

---

*Found a bug or have a feature request? Open an [issue](https://github.com/ForexTradingTools/fxtt-mt5-mtf-triple-moving-averages/issues) or use the suggestion form on the [product page](https://forextradingtools.eu).*
