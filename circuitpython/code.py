import board
import digitalio
import wifi
import socketpool
import adafruit_requests
import pwmio
import time

from adafruit_motor import servo

# create a PWMOut object on Pin A2.
pwm = pwmio.PWMOut(board.GP1, duty_cycle=2 ** 15, frequency=50)

# Create a servo object, my_servo.
my_servo = servo.Servo(pwm)

my_servo.angle = 0

# **CONFIGURE WiFi**
SSID = "wifi name"
PW = "wifi password"


# Connect to WiFi
print("Connecting to WiFi...")
wifi.radio.connect(SSID, PW)

# Get the dynamically assigned IP address
IP_ADDRESS = wifi.radio.ipv4_address
print(f"Connected! IP Address: {IP_ADDRESS}")

# **Setup GPIO**
gp0 = digitalio.DigitalInOut(board.GP0)
gp0.direction = digitalio.Direction.OUTPUT

gp28 = digitalio.DigitalInOut(board.GP28)
gp28.direction = digitalio.Direction.OUTPUT

# SPDX-FileCopyrightText: 2024 DJDevon3
#
# SPDX-License-Identifier: MIT

from adafruit_connection_manager import get_radio_socketpool
from adafruit_httpserver import Server, Request, Response


pool = get_radio_socketpool(wifi.radio)
server = Server(pool, "/static", debug=True)

def beep(duration):
    gp28.value = True  # Turn buzzer on
    time.sleep(duration) # Wait for the duration of the beep
    gp28.value = False # Turn buzzer off
    time.sleep(0.1)      # Short pause between beeps
    



@server.route("/on")
def base(request: Request):
    gp0.value = True
    countdown_beeps = [1/(i*2) for i in range(1,25)]  # Countdown with decreasing durations
    countdown_beeps.append(1.5)
    for duration in countdown_beeps:
        beep(duration)
    my_servo.angle = 90
    time.sleep(0.5)
    my_servo.angle = 0
    return Response(request, "Baloon popping sequence has begun")

@server.route("/off")
def base(request: Request):
    gp0.value = False
    gp28.value = False
    return Response(request, "Mission aborted")


server.serve_forever(str(wifi.radio.ipv4_address))

