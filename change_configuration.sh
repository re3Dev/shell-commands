#!/bin/bash

# The path to your .master.cfg file
config_file="/home/pi/printer_data/config/.master.cfg"

# Function to update the section name
update_section() {
    local old_section=$1
    local new_section=$2
    # Using sed to replace the old section name with the new one
    sed -i "s/\[$old_section\]/[$new_section]/" $config_file
}

# Function to update configuration parameters
update_config() {
    local param=$1
    local value=$2
    # Using sed to update the configuration file within the current section
    sed -i "/^\[$current_section\]/,/^\[/ {s/^$param=.*$/$param=$value/}" $config_file
}

# Function to set parameters based on the input number
set_combination() {
    local choice=$1
    case $choice in
        1)
            new_section="fff"
            platform_type="regular"
            board_type="archimajor"
            crammer_enabled="false"
            heater_bed_enabled="true"
            ;;
        2)
            new_section="fff"
            platform_type="xlt"
            board_type="archimajor"
            crammer_enabled="false"
            heater_bed_enabled="true"
            ;;
        3)
            new_section="fff"
            platform_type="terabot"
            board_type="archimajor"
            crammer_enabled="false"
            heater_bed_enabled="true"
            ;;
        4)
            new_section="fgf"
            platform_type="regular"
            board_type="archimajor"
            crammer_enabled="false"
            heater_bed_enabled="false"
            ;;
        5)
            new_section="fgf"
            platform_type="xlt"
            board_type="archimajor"
            crammer_enabled="false"
            heater_bed_enabled="false"
            ;;
        6)
            new_section="fgf"
            platform_type="terabot"
            board_type="archimajor"
            crammer_enabled="false"
            heater_bed_enabled="false"
            ;;
        7)
            new_section="fgf"
            platform_type="regular"
            board_type="archimajor"
            crammer_enabled="true"
            heater_bed_enabled="false"
            ;;
        8)
            new_section="fgf"
            platform_type="xlt"
            board_type="archimajor"
            crammer_enabled="true"
            heater_bed_enabled="false"
            ;;
        9)
            new_section="fgf"
            platform_type="terabot"
            board_type="archimajor"
            crammer_enabled="true"
            heater_bed_enabled="false"
            ;;
        *)
            echo "Invalid combination number. Please enter a number between 1-9."
            exit 1
            ;;
    esac

    # Update the section name
    update_section $current_section $new_section
    current_section=$new_section

    # Update the config file with the selected combination
    update_config "platform_type" "$platform_type"
    update_config "board_type" "$board_type"
    update_config "crammer_enabled" "$crammer_enabled"
    update_config "heater_bed_enabled" "$heater_bed_enabled"

    echo "Configuration updated to combination $choice with section [$new_section] successfully."
}

# Initial section name (you can change it as needed based on the default or expected section name before running the script)
current_section="fff"

# Check if an argument is provided
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <combination_number>"
    exit 1
fi

# Call the set_combination function with the input number
set_combination $1
