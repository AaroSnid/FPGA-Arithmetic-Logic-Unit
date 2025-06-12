# FPGA-Arithmetic-Logic-Unit
Created as a part of the LAB #2 for ECE 124

This project implements a simple arithmetic logic unit (ALU) on an FPGA using VHDL. The ALU supports basic bitwise logic operations (AND, OR, XOR, XNOR) as well as 4-bit binary addition. Input is provided through switches and pushbuttons, and output is displayed on a dual seven-segment display and LEDs. All components of the project, except the provided segment7_mux.vhd file which drives the display, were developed by myself and Ada Loveless.

### Project Overview

#### Seven Segment Display Decoder

A custom VHDL module was written to map 4-bit hexadecimal inputs to seven-segment display patterns. It supports hexadecimal values from 0 to F and was validated through waveform simulation.

#### Dual Display Handling

Two decoder instances handle separate 4-bit values. The outputs are multiplexed using the pre-provided segment7_mux.vhd, which time-shares the displays with automatic digit switching.

#### 4-to-1 Multiplexer

Implemented with VHDL’s with/select structure, this multiplexer is used to route one of four logic operations to the output based on user-selected inputs.

#### Logic Processor

Accepts two 4-bit inputs and performs a selected bitwise logic operation (AND, OR, XOR, XNOR). Operation selection is controlled by active-low pushbuttons.

#### Pushbutton Inverter

Converts the active-low signals from pushbuttons to active-high logic-level signals used for control logic.

#### 4-bit Full Adder

Adds two 4-bit inputs and handles carry propagation. A truth table was expanded from a half-adder to a full-adder to manage carry-in and generate carry-out correctly.

### System Architecture & Design Details
- Inputs

  - Switches (sw[7:0]): Used to input two 4-bit values (hex_A, hex_B)

  - Pushbuttons (pb_n[3:0]): Used to select the logic function (for ALU) or provide control signals

- Processing Units

  - Logic_Processor: Performs selected logic operations

  - full_adder: Adds 4-bit binary inputs with optional carry-in

  - hex_mux: Directs selected logic results to outputs

- Display Components

  - SevenSegment: Maps 4-bit inputs to segment display patterns

  - segment7_mux (provided): Time-multiplexes two seven-segment outputs onto shared display pins

- Outputs

  - Dual 7-segment displays: Show hexadecimal values of input data
  - LEDs: Display the binary result of ALU operations

#### Project Images
FPGA Output Example

Placeholder

Simulation Waveform Example

Placeholder
