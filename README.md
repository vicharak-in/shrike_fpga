# Shrike_FPGA
This repo is for the RP2040 + Forge FPGA Dev Board. 

![image](https://github.com/user-attachments/assets/6f404ca8-1808-4871-b96a-2030eb391555)
 
The repo contains a User Guide and example Project.

# Specs: 
1. FPGA - Renesas Forge FPGA https://www.renesas.com/en/products/programmable-mixed-signal-asic-ip-products/forgefpga-low-density-fpgas/slg47910-1k-lut-forgefpga
2. EDA Tool - Go configureSoftware Hub https://www.renesas.com/en/software-tool/go-configure-software-hub
3. Synthesis - Yosys ( inbuilt in EDA)
4. PPR - EFXL Flex logic ( inbuilt in EDA)

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

# updates 
 1/10/2024 The programming of the FPGA using the RP2040 is working .
 


# Application of our Board ( Ideas) 
 1. Peripheral Coprocessor 
 2. ROS Node using Micro ROS
 3. Protocol converter ( USB to uart ,  Uart-SPI, SPI-I2C etc)


![image_480](https://github.com/user-attachments/assets/b9ff4a67-2bfd-40b9-93d6-0fe1c51b91b2)
![image](https://github.com/user-attachments/assets/3359da79-6886-48a4-9754-b5aa416cc504)

# FPGA CPU PIN OUTS 
![image](https://github.com/user-attachments/assets/ed1769d6-760d-4312-85f5-bb914ad75cec)
