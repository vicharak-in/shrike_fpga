import machine
import utime
import binascii
import time

#Settings
start = time.ticks_ms()
SS = machine.Pin(1, machine.Pin.OUT); #Slave select
EN = machine.Pin(17, machine.Pin.OUT);
PWR = machine.Pin(16, machine.Pin.OUT);
led = machine.Pin(4, machine.Pin.OUT);



#Initialize SPI
SPI = machine.SPI(0,
                  baudrate = 10000000,
                  polarity = 0,
                  phase = 0,
                  bits = 8,
                  firstbit = machine.SPI.MSB,
                  sck = machine.Pin(2),
                  mosi = machine.Pin(3),
                  miso = machine.Pin(0))

file_name = 'FPGA_bitstream_MCU.bin'     

def send_bitstream_file(word_size=46408):
    try:

        with open(file_name, 'rb') as f:
            while True:
                # Read 4 bytes per line
                word = f.read(word_size)
                if not word:
                    break

                #hex_word = binascii.hexlify(word).decode('utf-8')
                #print(f"Send word: {hex_word}")
                SPI.write(word)
                
                #utime.sleep(0.001)

    except OSError as e:
        print(f"Can't open the file: {e}")
    except Exception as e:
        print(f"Error: {e}")

# Main
if "__main__":
    print("Starting uploading bitstream:")
    l_start = time.ticks_ms()
    utime.sleep(0.001)
    SS.value(0)
    EN.value(0)
    PWR.value(0)
    utime.sleep(0.001)
    EN.value(1)
    PWR.value(1)
    led.value(1)
    utime.sleep(0.001)
    SS.value(1)
    utime.sleep(0.002)
    SS.value(0)
    t_start = time.ticks_ms()
    send_bitstream_file()
    td_start = time.ticks_ms()
    utime.sleep(0.001)
    SS.value(1)
    end = time.ticks_ms()
    print(end - start)
    print(l_start)
    print(t_start)
    print(td_start)
    print (l_start - start)
    print(t_start - l_start)
    print(td_start - t_start)
    print(end - td_start)
    print(end) 
    print("Finished uploading bitstream")
    

