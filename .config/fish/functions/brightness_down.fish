function brightness_down
echo $(math max 100, $(cat /sys/class/backlight/intel_backlight/brightness) - 300) > /sys/class/backlight/intel_backlight/brightness
end
