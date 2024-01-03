function brightness_up
echo $(math min $(cat /sys/class/backlight/intel_backlight/max_brightness), $(cat /sys/class/backlight/intel_backlight/brightness) + 300) > /sys/class/backlight/intel_backlight/brightness 
end
