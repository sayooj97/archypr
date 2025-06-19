#!/bin/bash

# Desired sensor name (change to 'coretemp' or 'k10temp' based on your CPU)
SENSOR_NAME="k10temp"

# Target symlink path
SYMLINK_PATH="/tmp/cpu_temp"

# Remove existing symlink
[ -L "$SYMLINK_PATH" ] && rm "$SYMLINK_PATH"

# Find correct hwmon path
for HWMON in /sys/class/hwmon/hwmon*; do
  if grep -q "$SENSOR_NAME" "$HWMON/name"; then
    # Get the first temp file (you can change this if needed)
    TEMP_FILE="$HWMON/temp1_input"
    [ -f "$TEMP_FILE" ] && ln -s "$TEMP_FILE" "$SYMLINK_PATH"
    break
  fi
done
