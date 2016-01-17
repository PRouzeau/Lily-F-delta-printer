; Homing file for RepRapFirmware on D-Box - NO BED - reduce height if there is a bed
G91							; use relative positioning
;******* Change F500 in the following line by F5000 when you are finished commissioning
M906 X480 Y480 Z480         ; low current for homing against mechanical stop - shall be at 480 mini
							; 200 don't move, 300 move partly, 400 move ok, 450 jumps when homed 500 ok
G1 S2 X320 Y320 Z320 F3000	; move all carriages up 300mm S2 no stop detection
;G1 S0 Z520 F4000	; move all carriages up 520mm S0 no stop detection
;G1 S2 X-4 Y-4 Z-4 F1000	; move all towers down 4mm
;G1 S2 X8 Y8 Z8 F500		; move towers up 8mm, stopping at the mechanical endstops
M906 X1000 Y1000 Z1000      ; return to normal current
G92 X0 Y0 Z242.6			; defines the position when homed  - required while there is no endstops - beware assymetry
G1 Z-10 F500				; down a few mm so that we can centre the head
G90							; back to absolute positioning
G1 X0 Y0 F2000				; centre the head and set a reasonable feed rate
G1 Z20 F12000				; down near bed


