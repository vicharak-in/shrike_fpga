=====================================
XYZ Board - Hardware Manual
=====================================

Hardware Features :

    - Renesas FPGA 
    - RP2040
    - 128MB Flash Memory
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

The XYZ Board Packet with User IO's I have 23 RP2040 MCU IO's and 14 FPGA IO's all of 
which are 3.3V compatibe.
The Board also has Header for 1.8V , 3.3V Power Rails for power peripherals 

POWER 

The Board has a USB type C connector for both programming and power.
Connect the board to a host PC using a type c cable and you are good to go.

Programming 

Both the IC on the board have seprate programming modles. The RP2040 
can be programmed using MicroPthon or C whereas the FPGA neededs to be 
programmed using Verilog in The Renesas Go Configure IDE.

See This Guide to getting started with FPGA Programming. 


