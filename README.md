# SHRIKE_FPGA
### FPGA + RP2040 + endless learning 
![image](https://github.com/user-attachments/assets/6f404ca8-1808-4871-b96a-2030eb391555)

### Board level Block Diagram
 
![shrike](https://github.com/user-attachments/assets/6f585615-6b91-49ec-aa3d-26e50eec5a31)

## Useful Links : 
1. FPGA - [Renesas Forge FPGA ](https://www.renesas.com/en/products/programmable-mixed-signal-asic-ip-products/forgefpga-low-density-fpgas/slg47910-1k-lut-forgefpga)

2. EDA Tool - [Go Configure Software Hub](https://www.renesas.com/en/software-tool/go-configure-software-hub)

3. RP2040 - [Getting Started ](https://projects.raspberrypi.org/en/projects/getting-started-with-the-pico)

## 📫 Join our communities at :
  
   [<img src="./asset/discord-icon.svg" width="10%"/>](https://discord.com/invite/EhQy97CQ9G)  &nbsp; [<img src="./asset/x_icon.png" width="10%"/>](https://x.com/Vicharak_In)  &nbsp; [<img src="./asset/vicharak_icon.png" width="10%"/>](https://discuss.vicharak.in/)  &nbsp; [<img src="https://img.icons8.com/color/48/000000/linkedin.png" width="10%"/>](https://www.linkedin.com/company/vicharak-in)  &nbsp;

# Demo Projects - TODO ( Your contributions are appreciated )  

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

# Application of our Board ( Ideas) 
 1. Peripheral Coprocessor 
 2. ROS Node using Micro ROS
 3. Protocol converter ( USB to uart ,  Uart-SPI, SPI-I2C etc)

##### TODO --
1. Update these pinouts
2. Add Programmign guide
3. Write Geting Started Guide
4. Write a few Example project Guide
5. Add Usefull learning Resources
6. Restructure README

## FPGA Flashing time Analysis 
![image](https://github.com/user-attachments/assets/3359da79-6886-48a4-9754-b5aa416cc504)


# FPGA CPU Interconnect Pinouts 

<div align="center">

| FPGA PIN | RP 2040 PIN | S_Fun RP2040     | S_Fun FPGA         |
|----------|-------------|------------------|--------------------|
| 3        | 2           | GPIO             | SPI_SCLK           |
| 4        | 1           | UART RX / GPIO   | SPI_SS             |
| 5        | 3           | GPIO             | SPI_SI (MOSI)      |
| 6        | 0           | UART TX / GPIO   | SPI_SI (MISO) / CONFIG |
| 9        | 11          | GPIO             | GPIO               |

</div>


