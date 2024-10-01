import machine
import utime
import binascii

#Settings
SS = machine.Pin(17, machine.Pin.OUT); #Slave select
EN = machine.Pin(20, machine.Pin.OUT);
PWR = machine.Pin(21, machine.Pin.OUT);



#Initialize SPI
SPI = machine.SPI(0,
                  baudrate = 1000000,
                  polarity = 0,
                  phase = 0,
                  bits = 8,
                  firstbit = machine.SPI.MSB,
                  sck = machine.Pin(18),
                  mosi = machine.Pin(19),
                  miso = machine.Pin(16))

file_name = 'FPGA_bitstream_MCU.bin'

def send_bitstream_file(word_size=4):
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
    utime.sleep(0.01)
    SS.value(0)
    EN.value(0)
    PWR.value(0)
    utime.sleep(0.1)
    EN.value(1)
    PWR.value(1)
    utime.sleep(0.1)
    SS.value(1)
    utime.sleep(0.002)
    SS.value(0)
    send_bitstream_file()
    utime.sleep(0.1)
    SS.value(1)
    print("Finished uploading bitstream")
    