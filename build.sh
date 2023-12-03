#!/usr/bin/bash

# Specify the correct serial port for Arduino Mega (change this to your port)
SERIAL_PORT=/dev/ttyACM0

# Define the microcontroller type for Arduino Mega (ATmega2560)
MCU=atmega328p

# Define the clock frequency for Arduino Mega (usually 16MHz)
F_CPU=16000000UL

# Source file (change this to your actual source file name)
SOURCE_FILE=led.c

# Output file names
OUTPUT_FILE=led

# Compile the source code
avr-gcc -Os -DF_CPU=$F_CPU -mmcu=$MCU -c -o $OUTPUT_FILE.o $SOURCE_FILE


# Link the object file to create the binary
avr-gcc -o $OUTPUT_FILE.bin $OUTPUT_FILE.o

# Create a hex file from the binary
avr-objcopy -O ihex -R .eeprom $OUTPUT_FILE.bin $OUTPUT_FILE.hex


# Use avrdude to upload the hex file to the Arduino Mega
sudo avrdude -F -V -c arduino -p $MCU -P $SERIAL_PORT -b 115200 -U flash:w:$OUTPUT_FILE.hex
