; Configuration file for HXM 131/500 by PRZ - delta 3D printer
; (c) Pierre ROUZEAU  Jan 2016 - cc BY-SA, GFDL 1.2

; Communication and general
M111 S0                             ; Debug off
M550 PHXM				        	; Machine name (can be anything you like)
M551 Preprap                    	; Machine password (used by FTP and web interface)
M540 P0xBE:0xEF:0xDE:0xAD:0xFE:0x43 ; MAC Address
;*** Adjust the IP address and gateway in the following 2 lines to suit your network
M552 P0.0.0.0                  		; IP address - to be defined if the machine is not recognised by name
;M554 P192.168.1.1                  ; Gateway
M553 P255.255.255.0                 ; Netmask
M555 P2                             ; Set output to look like Marlin
G21                                 ; Work in millimetres
G90                                 ; Send absolute coordinates...
M83                                 ; ...but relative extruder moves

M106 I0 ; fans 
M106 S0 ; Turn off Fan 0 (backward compatible with older firmware)

; Axis and motor configuration
M569 P0 S1							; Drive 0 (X) goes forward
M569 P1 S1							; Drive 1 (Y) goes forward
M569 P2 S1							; Drive 2 (Z) goes forward
M569 P3 S0							; Drive 3 goes backwards
M569 P4 S0							; Drive 4: extruder goes backwards. 
;M574 X2 Y2 Z2 S1					; set endstop configuration (all endstops at high end, active high)
M574 X0 Y0 Z0 S1					; set endstop configuration (no endstops)

M665 R87.33 L190 B85 H242.6 X0 Y0	; set delta radius, diagonal rod length, printable radius, homed height and tower angle
; beware that without endstop the height is defined in the homedelta.g and supersedes this value
M666 X0 Y0 Z0			 		 	; put your endstop adjustments here
M92 X87.489 Y87.489 Z87.489  		; Set axis steps/mm
M906 X1000 Y1000 Z1000 E1000		; Set motor currents (mA) 
; beware that the values defined here for X,Y,Z are redefined in the homedelta.g and supersedes the values defined here
M201 X4000 Y4000 Z4000 E2000		; Accelerations (mm/s^2) 
M203 X15000 Y15000 Z15000 E3600		; Maximum speeds (mm/min)
M210 Z50                            ; Homing feedrate - not used ?
M566 X1200 Y1200 Z1200 E600			; Maximum instant speed changes mm/minute  !!extruder max speed change from 1200 to 600

; Thermistors
M305 P1 R4700                   	; Put your own H and/or L values here to set the first nozzle thermistor ADC correction

; Tool definitions
M563 P0 D0 H1                       ; Define tool 0
G10 P0 S60 R60                     	; Set tool 0 operating and standby temperatures
; M301 H1 P10 I0.1 D100 W180 ; temperature control PID default configuration
M301 H1 P12 I0.4 D80 W180 B30 T0.4  ; new configuration - not super stable - overshoot
;M301 H1 P10 I0.1 D100 T0.4 S1.0 W180.0 B30.0
M92 E420.0;  !! extrusion rate, with geared extruder - copied from Ormerod, nearly exact

;// Z probe and compensation definition
M558 P4 X0 Y0 Z0 H2					; Z probe is a switch and is not used for homing any axes
G31 X0 Y0 Z0 P200			    	; Set the zprobe height (offset) and threshold (put your own values here)
; Z offset is defined as 0, because the values are defined for each calibration point in bed.g

;*** If you are using axis compensation, put the figures in the following command
M556 S78 X0 Y0 Z0                   ; Axis compensation here

M404 N1.75 D0.4						;  filament diameter 1.75, nozzle 0.4 - used by web interface 

