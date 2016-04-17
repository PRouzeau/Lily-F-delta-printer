;prepare the machine after a cold start
M104 S155		; set the current hotend temperature to 100 and wait for it - M104 don't wait 
G28				; home
T0
M109 S155		; set the current hotend temperature to 100 and wait for it - M104 don't wait 
G32				; calibrate only while hot
;M98 P/macros/brush.g ; yet there is no brush possibilities (arm cannot go low to run outside limits)
G32				; 2nd calibration as the first one rarely ok with no switches
