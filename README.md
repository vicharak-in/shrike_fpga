# SHRIKE_FPGA

Shrike is world's first fully open source FPGA Dev board based on Renesas Forge FPGA SLG47910 and RP2040. 
We at vicharak have kept in mind need of a learner, maker and a hobbist while desiging this art. This dev board will be your stepping stone in the field of FPGA , reconfigrable and hetrogenous computing . 

![image](https://github.com/user-attachments/assets/6f404ca8-1808-4871-b96a-2030eb391555)

### Board level Block Diagram
 
![shrike](https://github.com/user-attachments/assets/6f585615-6b91-49ec-aa3d-26e50eec5a31)

### Key Features : 
1.  RP2040 ARM Cortex M0 
2.  FPGA with 1100 Luts
3.  PMOD Compatible Connector
4.  Bread Board compatible Io's from both FPGA and MCU 
5.  High Speed IO interface Between FPGA and MCU
6.  QSPI Flash 
7.  2x User LED's
8.  Type C Port for Power and Programming 

## Resources : 

1. [Getting Started Guide ](./Docs/FPGA_Programming.rst)
2. [Comparitive analysis between cpu and FPGA on Shrike](./Docs/RP2040vsFPGA.md)

## Useful Links : 
1. FPGA Datasheet - [Renesas Forge FPGA ](https://www.renesas.com/en/products/programmable-mixed-signal-asic-ip-products/forgefpga-low-density-fpgas/slg47910-1k-lut-forgefpga)

2. EDA Tool - [Go Configure Software Hub](https://www.renesas.com/en/software-tool/go-configure-software-hub)

3. RP2040 Related Resources- [Getting Started ](https://projects.raspberrypi.org/en/projects/getting-started-with-the-pico)

## 📫 Join our communities at :
  
   [<img src="./asset/discord-icon.svg" width="10%"/>](https://discord.com/invite/EhQy97CQ9G)  &nbsp; [<img src="./asset/x_icon.png" width="10%"/>](https://x.com/Vicharak_In)  &nbsp; [<img src="./asset/vicharak_icon.png" width="10%"/>](https://discuss.vicharak.in/)  &nbsp; [<img src="https://img.icons8.com/color/48/000000/linkedin.png" width="10%"/>](https://www.linkedin.com/company/vicharak-in)  &nbsp; [<img src="./asset/reddit_icon.jpeg" width="10%"/>](https://www.reddit.com/r/Vicharak/)  &nbsp;



### Note 

We are building a ecosystem for learners makers and hobbist around shrike and the projects that will follow in the future thus we request you comtribution in the same. Join our communities across all the platfroms ,pitch and showcase your ideas with Shrike. 

Thank You 

## Potential application of Shrike ( Ideas) 
 1. Peripheral Coprocessor 
 2. ROS Node using Micro ROS
 3. Protocol converter (USB to uart ,  Uart-SPI, SPI-I2C etc)

### Demo Projects - TODO ( Your contributions are appreciated )  

1. LED Water                         
2. Servo Controller  
3. I2C to Uart 
4. UART to 7 seg  
5. RISC V SERV 
7. LCD Display 16*2 
8. Periplex (port) 
9. 4 bit 7 segment Controller 
10. SPI Display Driver 
11. 8 Bit protocol for v2 
12. FFT 
13. PWM Coprocessor ( servo and motor controls)
14. Signal Genrator  ( Pll for higher frequencies)
15. Random number genrator 
16. Counter 4 bit                                       -- DONE



## FPGA Flashing time Analysis 
![image](https://github.com/user-attachments/assets/3359da79-6886-48a4-9754-b5aa416cc504)


## FPGA CPU Interconnect Pinouts 

<div align="center">

| FPGA PIN | RP 2040 PIN | S_Fun RP2040     | S_Fun FPGA         |
|----------|-------------|------------------|--------------------|
| 3        | 2           | GPIO             | SPI_SCLK           |
| 4        | 1           | UART RX / GPIO   | SPI_SS             |
| 5        | 3           | GPIO             | SPI_SI (MOSI)      |
| 6        | 0           | UART TX / GPIO   | SPI_SI (MISO) / CONFIG |
| 9        | 11          | GPIO             | GPIO               |

</div>


