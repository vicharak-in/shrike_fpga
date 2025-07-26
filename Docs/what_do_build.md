# ✅ What You Can & Should Build on Shrike 

## 🧠 Logic & Compute Cores
- [ ] **Brainfuck CPU** – 8-opcode minimalist interpreter in FPGA, input/output via RP2040
- [ ] **8-bit Soft CPU** – Tiny custom CPU core running instructions from RP2040
- [ ] **Bit-serial ALU** – Shift-register based multiplier or adder
- [ ] **FSM Visualizer** – FPGA runs a state machine, RP2040 displays current state

## 🔧 Peripherals & Protocol Engines
- [ ] **I²C Address Translator** – FPGA remaps I²C slave addresses in-line
- [ ] **Quadrature Decoder** – FPGA decodes rotary encoder, RP2040 reads angle
- [ ] **PWM Generator** – FPGA generates variable PWM, RP2040 adjusts duty cycle
- [ ] **SPI Slave Peripheral** – FPGA acts as SPI slave with custom logic

## ⌛ Timing & Measurement
- [ ] **Edge Detector** – FPGA detects rising/falling edges, sends event to RP2040
- [ ] **One-Shot Pulse Generator** – FPGA generates a clean pulse from noisy input
- [ ] **Pulse Width Counter** – FPGA measures time between signal edges

## 🎮 Interactive Demos
- [ ] **LED Driver** – FPGA lights LEDs based on logic or instructions
- [ ] **Button Matrix Scanner** – FPGA scans matrix, RP2040 interprets key events
- [ ] **Custom Gamepad** – FPGA handles button debounce, RP2040 presents USB HID

## 🎓 Educational / Visual Tools
- [ ] **Tiny Logic Analyzer** – FPGA samples signals, RP2040 streams to PC
- [ ] **Waveform Generator** – FPGA produces square/triangle/sawtooth wave
- [ ] **Live Verilog Upload Tool** – Use RP2040 + WebSerial to upload designs

## 🎲 Randomness & Security
- [ ] **LFSR-based PRNG** – Linear feedback shift register in FPGA, seeded by RP2040
- [ ] **Simple XOR Cipher Core** – FPGA does byte-wise XOR crypto

## 📟 Display / Output (using external peripherals)
- [ ] **ILI9225 TFT Driver** – RP2040 handles images, FPGA assists in timing or drawing
- [ ] **7-Segment Display Controller** – FPGA drives multiplexed display, RP2040 sets digits
- [ ] **Signal Visualizer** – FPGA sends sensor or logic info to TFT

## 📦 System & Development Features
- [ ] **Bitstream Uploader** – Upload precompiled bitstreams from RP2040 flash or WebSerial
- [ ] **Logic Instruction Loader** – RP2040 sends runtime logic stream to FPGA
- [ ] **Self-Test Mode** – FPGA runs built-in diagnostic, RP2040 logs output
