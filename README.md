# openplc-analog-process-indicator
Arduino Uno + OpenPLC Structured Text process indicator with analog input and physical LED outputs.

# OpenPLC Analog Process Indicator

My first mechatronics / PLC bench project.

This project uses a physical potentiometer as an analog process input, an Arduino Uno as the I/O interface, and OpenPLC Structured Text to classify the process into LOW, MEDIUM, and HIGH states.

![Bench Setup](images/bench-setup.jpg)

---

## System Architecture

```text
Potentiometer
     ↓
Analog Voltage
     ↓
Arduino A0
     ↓
OpenPLC %IW0
     ↓
potValue
     ↓
Structured Text
     ↓
Digital Outputs
     ↓
Green / Yellow / Red LEDs
```

---

## Process States

| Analog Value | State | Output |
|---:|---|---|
| 0–341 | LOW | Green |
| 342–682 | MEDIUM | Yellow |
| 683–1023 | HIGH | Red |

---

## Structured Text

```iecst
IF potValue <= 341 THEN
    Green := TRUE;
    Yellow := FALSE;
    Red := FALSE;

ELSIF potValue <= 682 THEN
    Green := FALSE;
    Yellow := TRUE;
    Red := FALSE;

ELSE
    Green := FALSE;
    Yellow := FALSE;
    Red := TRUE;
END_IF;
```

---

## Hardware

- Arduino Uno
- Breadboard
- Potentiometer
- Green LED
- Yellow LED
- Red LED
- 220 Ω resistors
- Jumper wires
- Multimeter

---

## Software

- OpenPLC Editor
- IEC 61131-3 Structured Text
- Arduino Uno target

---

## What I Learned

- Measuring DC voltage with a multimeter
- Measuring resistance and continuity
- Breadboard power distribution
- Arduino analog input
- Analog-to-digital conversion
- OpenPLC I/O mapping
- IEC 61131-3 Structured Text
- PLC input/output troubleshooting
- Testing outputs independently before troubleshooting inputs

---

## Troubleshooting

The first successful build powered the green LED, but turning the potentiometer did not change the process state.

I isolated the output side by manually commanding each PLC output:

```text
Green  ✅
Yellow ✅
Red    ✅
```

Since all three physical outputs worked, the fault had to be upstream.

Following the signal path led to the actual problem:

**Arduino A0 had not been mapped correctly to the OpenPLC analog input.**

After correcting the A0 mapping, rebuilding, and uploading the firmware, the physical potentiometer successfully controlled all three process states.

```text
LOW    → GREEN
MEDIUM → YELLOW
HIGH   → RED
```

---

## Technician Principle

### OHM — Follow the Signal

```text
Observe
   ↓
Measure
   ↓
Isolate
   ↓
Verify
   ↓
Correct
   ↓
Retest
```

---

## Current Status

✅ Potentiometer input  
✅ Arduino A0  
✅ OpenPLC analog mapping  
✅ Structured Text control logic  
✅ Green output  
✅ Yellow output  
✅ Red output  
✅ Physical process-state transitions  

---

## Next Steps

- Add hysteresis around process thresholds
- Add pushbutton reset / acknowledge
- Add HIGH-state alarm
- Add motor or fan output
- Build a PLC state machine
- Add Node-RED visualization
- Add Splunk telemetry

---

## Why I Built This

I am building a hands-on mechatronics training bench to learn industrial automation from the signal level upward.

Rather than treating the Arduino, PLC software, meter, sensors, and outputs as separate tools, the goal is to understand how they work together as one control system.

**Sense → Decide → Act**

---

*First working OpenPLC / physical-I/O mechatronics project — September 2026.*
