# BRAM 4 bit test --  Scrpit 
from machine import Pin, UART
import time

# Initialize UART on Pin 1
#uart = UART(0, baudrate=115200, tx=Pin(0), rx=Pin(1))

# Set up pins

pinRE = Pin(9, Pin.OUT)
pinWE = Pin(10, Pin.OUT)
pinIN0  = Pin(3, Pin.IN)  # output from fpga 
pinIN1  = Pin(0, Pin.IN)
pinIN2  = Pin(17, Pin.IN)
pinIN3  = Pin(7, Pin.IN)
pinempty  = Pin(11, Pin.IN)
pinfull  = Pin(6, Pin.IN)

# 
pinOUT0  = Pin(2, Pin.OUT)  # input to fpga 
pinOUT1  = Pin(1, Pin.OUT)
pinOUT2  = Pin(23, Pin.OUT)
pinOUT3  = Pin(22, Pin.OUT)



# Set pin 1 and pin 2 states
#pinWE.value(1)
#time.sleep(0.000000001)


pinOUT0.value(0)
pinOUT1.value(0)
pinOUT2.value(1)
pinOUT3.value(1)
#pinRE.value(0)
#time.sleep_ms(1)

#pinWE.value(0)
#time.sleep(0.000000001)
#pinRE.value(0)
pinWE.value(0)
pinRE.value(0)
time.sleep(0.0000000001)
pinWE.value(1)
pinRE.value(0)
time.sleep(0.000000001)
pinRE.value(1)

while True:
    #
    # Read the state of pin 5
    #pinWE.value(0)
    #pinRE.value(1)
    
    
    pinempty_state = pinempty.value()
    pinfull_state = pinfull.value() 
    pinIN0_state = pinIN0.value()
    pinIN1_state = pinIN1.value()
    pinIN2_state = pinIN2.value()
    pinIN3_state = pinIN3.value()
    
    
    #pin8_state = pin8.value()
    #data = uart.read()  # Read data from UART
  #  print("Received:", data)
                
    print(pinempty_state,pinfull_state,pinIN0_state,pinIN1_state,pinIN2_state,pinIN3_state)
   # 
    #print("Pin 8 state:", pin8_state)
    #time.sleep(1)  # Add a delay to reduce the frequency of state checks
