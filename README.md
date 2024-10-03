# forge_fpga
This repo is for the RP2040 + Forge FPGA Dev Board.  
The repo contains a LED blinking example project the bitsream for which is provided by the Renesas FAE Orest.Krykh.  
This is not teseted on the FPGA yet as there has been some hardware problem ( could be a software (flashing ) as well)  related to logic level disparity between the RP2040 and FPGA.  
We are trying to program the FPGA usign the RP2040 i.e as a SPI Slave mode However right now the support for this mode is very crude in the FORGE FPGA (GO Configure sotfware) I have been in touch with the various FAE in the companay and there has been progress. It should be figures out soon in hte next update of the software which is promised by the end on month of Sep 2024.

# Specs: 
1. FPGA - Renesas Forge FPGA https://www.renesas.com/en/products/programmable-mixed-signal-asic-ip-products/forgefpga-low-density-fpgas/slg47910-1k-lut-forgefpga
2. EDA Tool - Go configureSoftware Hub https://www.renesas.com/en/software-tool/go-configure-software-hub
3. Synthesis - Yosys ( inbuilt in EDA)
4. PPR - EFXL Flex logic ( inbuilt in EDA) 

# updates 
 1/10/2024 The programming of the FPGA using the RP2040 is working .
 


# Application of our custom Board ( Ideas) 
 1. Peripheral Coprocessor ( obiviously same as periplex but very smaller and less moduler due to 1K LUT )
 2. ROS Node using Micro ROS
 3. Protocol converter ( USB to uart ,  Uart-SPI, SPI-I2C etc),
 4. A Coprocessor to the Periplex Project ( not sure how but can be done)
 5. 


![image_480](https://github.com/user-attachments/assets/b9ff4a67-2bfd-40b9-93d6-0fe1c51b91b2)



contact details for the FAE in the Renesas : 
1. orest.krykh.wm@renesas.com  (Orest.krykh)
2. Iryna Bilyk iryna.bilyk.xj@renesas.com
3. Akanksha Agarwal ( Linkedin)
4. fpga@renesas.com
