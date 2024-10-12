from machine import Pin, UART
import time

# Initialize UART on Pin 1
uart = UART(0, baudrate=115200, tx=Pin(0), rx=Pin(1))

# Set up pins

pin2 = Pin(2, Pin.OUT)
pin5 = Pin(3, Pin.IN)

# Function to send data via UART
def send_uart(data):
    uart.write(data)
    print("Sent:", data)

# Set pin 1 and pin 2 states
pin2.value(1)
time.sleep_ms(100)
pin2.value(0)


while True:
    # Send data periodically
    send_uart(b'Hello')
    time.sleep(0.00000002)  # Delay before sending again
    send_uart(b'supp')
    time.sleep(0.00000002)  # Delay before sending again
    send_uart(b'nice')
    time.sleep(0.00000002)
    send_uart(b'howyoudoing')
    
    
    # Read UART input
    #if uart.any():
    data = uart.read()  # Read data from UART
    print("Received:", data)
        
    # Read the state of pin 5
    pin5_state = pin5.value()
    print("Pin 5 state:", pin5_state)
    time.sleep(1)  # Add a delay to reduce the frequency of state checks
