
---
title: "MOS VOC Sensor Array - icell"
author: "jaycam"
discord: ""
description: "Analog unit cell (icell) for a 2x8 MOS VOC sensor array featuring 1.8V control logic and thick-oxide analog IOs."
---

## How it works

This project implements the analog unit cell (`icell`) designed for a 2x8 Metal-Oxide Semiconductor (MOS) Volatile Organic Compound (VOC) sensor array. 

The cell utilizes a hybrid voltage architecture:
* **Control Logic:** Standard 1.8V thin-oxide devices (`sky130_fd_pr__pfet_01v8` and `nfet_01v8`) handle the digital switching and enable logic (Cn, Sn, Rn).
* **Analog Interfacing:** Thick-oxide 5V devices (`sky130_fd_pr__nfet_g5v0d10v5`) are used to interface with the external sensor elements to handle higher voltage compliance for the sensor bias (`Vbias`) and current output (`Iout`).

When the unit cell is selected via the control logic, the thick-oxide switches pass the `Vbias` to the external sensor element and route the resulting `Iout` to the analog output pad for external measurement.

## How to test

1. Ensure power is supplied to the standard 1.8V digital rails (VPWR/VGND) for the control logic to function.
2. Apply the desired selection signals to the standard digital input pins (Cn, Sn, Rn) to activate the cell.
3. Apply a bias voltage to the `Vbias` analog pin.
4. Measure the resulting current or voltage drop on the `Iout` analog pin to characterize the internal thick-oxide switch resistance and verify the analog path.

## External hardware

To fully test the intended application, this IC requires:
* An external MOS VOC sensor element to connect across the analog bias and output paths.
* A Source Measure Unit (SMU) or equivalent sensitive picoammeter/transimpedance amplifier (TIA) to read the `Iout` pin, as VOC sensor currents can be extremely low depending on the target gas concentration.
