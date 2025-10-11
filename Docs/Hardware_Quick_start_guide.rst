=====================================
Shrike FPGA - Hardware Overview
=====================================
Shrike is a low-cost, low-power, and easy-to-use FPGA development board that combines both the 
Renesas FPGA and the RP2040 microcontroller. It is designed for hobbyists, students, and professionals to explore and prototype FPGA-based designs with ease. 

.. image:: ./../asset/shrike_lite.svg
   :scale: 100
   :alt: Shrike_Dev_Board
   :align: center

The board features a variety of peripherals to support various applications. Some of the key features include: 

Hardware Features :
####################

    - Renesas FPGA 
    - RP2040
    - 128Mb Flash Memory
    - PMOD Connector 
    - Reset Button 
    - Boot Select Button 
    - USB Type C for Power & Programming 
    - RP2040 User LED 
    - FPGA User LED 
    - 23 RP2040 GPIO'
    - 14 FPGA GPIO's 
    - 6 Bit FPGA CPU Link 
    - Bread Board Compatible 


GPIO's 
################

The Shrike Packed with User IO's I have 23 RP2040 MCU IO's and 14 FPGA IO's all of which are 3.3V compatible.

The Board also has Header for 3.3V and 5V Power Rails for powering eternal peripherals. 

PMOD Connector
################
The Shrike Board has a PMOD connector for connecting to various peripherals the PMOD connector is 3.3 V Compatible


Type C Port 
################
The Board has a USB type C connector for both programming and power.
Connect the board to a host PC using a type c cable and you are good to go.

User LED's
################

The board has two user LED's one for the RP2040 and one for the FPGA. The LED's are connected to GPIO pins of the respective chips.
The RP2040/RP2350 LED is connected to GPIO 04 and the FPGA LED is connected to GPIO 16.
The LED's are active high meaning that when the GPIO pin is set to hight the LED will turn on and when the GPIO pin is set to low the LED will turn off.

Programming 
################


Both the IC on the board have seprate programming models. The RP2040 
can be programmed using MicroPython or C whereas the FPGA needed to be 

programmed using Verilog in The Renesas Go Configure IDE.

Powering the Board
##################
The board can be powered using one of these two methods:
 1. The USB Type C port
 2. Header 1 marked 3.3V and any of the GND pins on the board.

** Note**: The board can be powered using the USB Type C port or the header marked 3.3V. Do not power the board using both methods at the same time as this may damage the board.

The voltage on the Type C should be 5V and the voltage on the header should be 3.3V. The board has a voltage regulator that converts the 5V to 3.3V for the RP2040 and the FPGA.
The voltage on the PMOD connector is 3.3V.

See `here <./getting_started.md>`_  Guide to getting started with FPGA Programming. 

