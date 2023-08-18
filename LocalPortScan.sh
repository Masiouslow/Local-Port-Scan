#!/bin/bash

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Leave 
function ctrl_c() {
    echo -e "\n\n${redColour}[!]${endColour}${yellowColour} Leaving...${endColour}\n"
    exit 1
}

# Ctrl+C
trap ctrl_c INT

# Validate port
function validate_port_range() {
  local port_range="$1"
  #  verify format  "(port port)"
  local regex="^[0-9]+ [0-9]+$"

  if [[ "$port_range" =~ $regex ]]; then
    return 0  # Valid format
  else
    return 1  # Invalid format
  fi
}

echo -e "${blueColour}Enter the port range to scan${endColour}${yellowColour}(Port Port):${endColour}"
read port_range

# Validate input entered
if validate_port_range "$port_range"; then
  echo -e "${blueColour}Input valid:${endColour}${greenColour} $port_range${endColour}"
else
  echo -e "${yellowColor}Invalid input. must follow the format:${endColour} ${redColour}'(Port  Port)'${endColour}."
fi

# Slipt the Port range
read lower_port upper_port <<< "$port_range"

for port in $(seq "$lower_port" "$upper_port"); do
       ( echo -e '' > /dev/tcp/127.0.0.1/$port) 2>/dev/null &&  echo -e "${blueColour}Port ${endColour}${greenColour}$port ${endColour}${blueColour}is open.${endColour}"
done
