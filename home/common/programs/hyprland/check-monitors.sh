#!/usr/bin/env bash

declare -a monitor_names
declare -a monitor_modes

get_highest_res() {
  local highest_res=""
  local highest_res_width=0
  local highest_res_height=0
  
  for mode in $1; do
    resolution="${mode%@*}"           # Extract resolution
    refresh_rate="${mode#*@}"         # Extract refresh rate
    IFS='x' read -r width height <<< "$resolution"  # Split resolution into width and height

    # Compare to find the highest resolution
    if [[ -z "$highest_res" || $((width * height)) -gt $((highest_res_width * highest_res_height)) ]]; then
      highest_res="$resolution@$refresh_rate"
      highest_res_width=$width
      highest_res_height=$height
    fi
  done
  
  echo "$highest_res"
}

# Read the output of hyprctl monitors once
output=$(hyprctl monitors)

# Extract monitor names and available modes
while IFS= read -r line; do
  # Extract monitor names
  if [[ $line =~ ^Monitor ]]; then
    monitor_name=$(echo "$line" | awk '{print $2}')
    monitor_names+=("$monitor_name")
    
    # Look ahead to find availableModes
    read -r next_line
    while [[ $next_line != "" ]]; do
      if [[ $next_line =~ availableModes ]]; then
        modes=$(echo "$next_line" | awk -F ': ' '{print $2}')
        monitor_modes+=("$modes")
        break
      fi
      read -r next_line
    done
  fi
done <<< "$output"

# Create monitors.nix file and populate it with monitor names and their highest resolutions
{
  echo "{"
  
  # Loop through monitors and extract highest resolutions
  for index in "${!monitor_names[@]}"; do
    name=${monitor_names[index]}
    modes=${monitor_modes[index]}
    
    # If modes are found, get the highest resolution
    if [[ -n "$modes" ]]; then
      highest_res=$(get_highest_res "$modes")  # Get the highest resolution for each monitor
      # Print the monitor name and highest resolution in the desired format
      echo "  $name = \"$highest_res\";"
    else
      # Handle case where no modes are found
      echo "  $name = \"No available modes\";"
    fi
  done
  
  echo "}"
} > monitors.nix
