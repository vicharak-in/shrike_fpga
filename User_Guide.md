# -- Bitstream Flash USER Guide 

Hello SO you have got your Handles On our  -- Board . Congrats You are in for a smooth ride for your first project hold on tight.

So first thing first we would have to download the EDA tool for the FPGA You can Find it here. 
Here are the few more software you will require.

1. GO Configure Software Hub ( Renesas) 
2. Thonny IDE
3. GTKWave

Alright so you have got the require software on you PC. Now lets flash bitsream to the FPGA The guide to generating the bitsream can be found here. 

Step to flash the bitstream 
1. Connect the -- Board to you PC
2. Open the Thonny connect the board to the thonny for button right corner it should show up as micropython device.
3. Create a new .py file on the board and copy the MCU_bitstream_flash.py script to it .
4. Next step is to get the required bitstream on the board to do that in Thonny navigate to View >> Files now navigate to the bitstream file on your PC and then right click and upload to .
   This step will upload you bitstream .bin file to the onboard flash.
5. Now you have to open the MCU_bitsream_flash.py on you board and run .
6. Hurray you have got your first bitstream flashed your board.


   
