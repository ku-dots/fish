if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x QT_QPA_PLATFORMTHEME "qt5ct"
    set -x QT_QPA_PLATFORM "xcb"
    set -x TERM xterm-256color
end

cat ~/.cache/wal/sequences

function fish_greeting
    neofetch
end
alias nlear='clear; neofetch'

fish_add_path /home/BNN/.spicetify

function output_input
    # Create a new virtual source that other apps can use as input
    set SOURCE_NAME "OutputInput"

    # Create a null sink to serve as the mixing point
    pactl load-module module-null-sink sink_name="$SOURCE_NAME"_mix sink_properties=device.    description="$SOURCE_NAME"_mix

    # Create a virtual source that monitors the null sink, making the mixed audio available as input
    pactl load-module module-virtual-source source_name=$SOURCE_NAME master="$SOURCE_NAME"_mix.monitor     source_properties=device.description="OutputInput"

    # Get the name of the current default output sink
    set DEFAULT_SINK (pactl info | grep "Default Sink" | awk '{print $3}')

    # Create a loopback from the default sink's monitor to our null sink
    if test -n "$DEFAULT_SINK"
        pactl load-module module-loopback source="$DEFAULT_SINK.monitor" sink="$SOURCE_NAME"_mix latency_msec=1
    else
        echo "Error: Could not find default output sink."
    end
end

# Created by `pipx` on 2024-11-11 13:58:08
set PATH $PATH /home/bnn/.local/bin
