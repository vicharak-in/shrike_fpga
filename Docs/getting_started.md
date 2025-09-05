# Getting Started with Shrike FPGA  

Hello, so you have got the Shrike FPGA , Nice ! Now lets blink some leds and say hello to world of hardware. 

We will see along the way how to setup the required software and toolchain as well.



Now that you have your hardware in hand lets follow these steps. 


### 1. Uploading the shrike UF2  

We have created custom UF2 for shrike this contains a shrike.py library that has custom function to flash fpga and few others. You can use the normal rpi micro python uf2 as well however the step's would be different. 

Now we will here safely assume that you will be using our uf2.


1. Download the uf2 corresponding to your board version from the shrike's [Github](https://github.com/vicharak-in/shrike_fpga).
2. Hold the boot button on the board and connect it the your pc now shrike will show up as as storage device.
3. Copy the downloaded uf2 in storage device you can simply drag and drop in mostly all the devices. 
4. After the successful copying the storage device should disappear.

Congratulations you have successfully uploaded the uf2. 

### 2. Get the bitstream(.bin) for led blink 

To programme a FPGA you will require  bitstream file this is much like a firmware for MCU's we will see how to generate these but for now we have uploaded the bitstream required for led_bin you can download them the corresponding to your board's version [here](https://github.com/vicharak-in/shrike_fpga/tree/main/Test_bitstreams/v1_4). 

Now that you have both uf2 and bin file settled up lets move forward and upload the bitstream to board.

### 3. Getting the Thonny IDE 

The bitstream can be uploaded on the shrike using one of these two ways 
   1. Using a GUI Based-IDE (Thonny)
   2. Using Command line interface (CLI)

In this guide we will use Thonny however guide to programme using CLI can be found [here](./shrike_cli_guide.md).

Now we will need to get thonny on our pc. Installation is quite straight forward You can download it from [here](https://thonny.org/). 

Now that we have got all the required tools set-ed up let blink some leds.

Open thonny and connect the board to the laptop (do not press boot button this time). And do these two things 
   1. Connect the board from the bottom right corner. 
   2. Go to file view mode in the thonny to see the rp2040 as a file system.

### 4. Flashing the bitstream  
Now you should see both the your pc and rp2040 file's on the left windows now we have to transfer the led_blink.bin file to the rp2040. To do so find the file on your system then right click and upload.

Now we will have to flash this file to the fpga to do so we will use the function 

```
    shrike.flash("<your_bitstream_name>.bin")
```
in thonny open a new python file and write this python script 
```
    import shrike
    shrike.flash("blink_led.bin")
```

Save this file to your board (RP2040) and run it. (to run this file on board boot up just name it as main.py)

If everything has been done correctly you should see led blinking on the board.





