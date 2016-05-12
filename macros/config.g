; Configuration file for Lily 'F' 131/500 by PRZ - delta 3D printer
; (c) Pierre ROUZEAU  April 2016 - cc BY-SA, GFDL 1.2
Shall use recent version of DC42 Fork - 1.12 or later and DWC 1.11 or later
Note that these DC42 recent versions need at least version 1.08 of the web interface

; Communication and general
M111 S0                             ; Debug off
M550 PLily				        	; Machine name (use http://Lily for web access, can be anything else) - Netbios name
M551 Preprap                    	; Machine password (used by FTP AND web interface)
M540 P0xBE:0xEF:0xDE:0xAD:0xFE:0x43 ; MAC Address - shall be different for each machine on the same network
;*** Adjust the IP address and gateway in the following 2 lines to suit your network
M552 P0.0.0.0                  		; IP address - to be defined if the machine is not recognised by name
;M554 P192.168.1.1                  ; Gateway
M553 P255.255.255.0                 ; Netmask

M555 P2                             ; Set output to look like Marlin
G21                                 ; Work in millimetres
G90                                 ; Send absolute coordinates...
M83                                 ; ...but relative extruder moves

M106 I0 ; fans 						; for 0.8.5 board, you shall use recent DC42 versions
M106 S0 ; Turn off Fan 0 (backward compatible with older firmware)

; Axis and motor configuration
M569 P0 S0							; Drive 0 (X) goes forward - adjust depending your configuration
M569 P1 S0							; Drive 1 (Y) goes forward - adjust depending your configuration
M569 P2 S0							; Drive 2 (Z) goes forward - adjust depending your configuration
M569 P3 S0							; Drive 3: extruder - adjust depending your configuration
; beware old firmware version, extruder was P4
; instead of reversing by software, the motor plug may be inverted (imperatively POWER OFF, that may kill the board)
; if this is feasible (non polarized plugs)

;M574 X2 Y2 Z2 S1					; set endstop configuration (all endstops at high end, active high)
M574 X0 Y0 Z0 S1					; set endstop configuration (no endstops)

M665 R87 L190 B85 H243.41 X0 Y0		; set delta radius, diagonal rod length, printable radius, homed height and tower angle
; beware that without endstop the height is defined in the homedelta.g and supersedes this value
M666 X0 Y0 Z0			 		 	; put your endstop adjustments here
M92 X87.489 Y87.489 Z87.489  		; Set axis steps/mm
M906 X1000 Y1000 Z1000 E1100 I45	; Set motor currents (mA)  I45 is the idling percentage (default 30)
; beware that the values defined above for X,Y,Z are redefined in the homedelta.g and supersedes the values defined here
M201 X5000 Y5000 Z5000 E2000		; Accelerations (mm/s^2) 
; beware that the values defined above for X,Y,Z are redefined in the homedelta.g and supersedes the values defined here
M203 X15000 Y15000 Z15000 E3600		; Maximum speeds (mm/min)
M210 Z50                            ; Homing feedrate - not used ?
M566 X1200 Y1200 Z1200 E600			; Maximum instant speed changes mm/minute  !!extruder max speed change from 1200 to 600

; Thermistors
M305 P1 R4700                   	; Put your own H and/or L values here to set the first nozzle thermistor ADC correction
									; to compare values, your ADC shall be calibrated ! see commissioning

M143 S300							; maximum hot-end temperature  - default 260°C
									
; Tool definitions
M563 P0 D0 H1                       ; Define tool 0
G10 P0 S60 R60                     	; Set tool 0 operating and standby temperatures
M301 H1 P12 I0.25 D70 T0.21 S0.7 W150 B20;temperature control PID for hotend insulated with Kapton
;M572 D0 S0.05 		; elasticity compensation for the Bowden tube, 1rst extruder - abandoned due to high vibration on extruder
M92 E420.0;  !! extrusion rate, with supplied geared extruder - copied from Ormerod, nearly exact
// for direct drive extruder, the value may be from 140 to 150
// you SHALL calibrate this value, do not rely on defaults

;// Z probe and compensation definition
M558 P4 X0 Y0 Z0 H2					; Z probe is a switch and is not used for homing any axes
G31 X0 Y0 Z0 P200			    	; Set the zprobe height (offset) and threshold (put your own values here)
; Z offset is defined as 0, because the values are defined for each calibration point in bed.g

; Geometry correction
M556 S78 X0 Y0 Z0                   ; Axis compensation here (X/Y/Z not perpendicular)
M579 X1.0068 Y1.0068				; Part scale (here the calibration part was smaller than required) - adjust to your own measures

M404 N1.75 D0.4						; Filament diameter 1.75, nozzle 0.4 - used by web interface only

M98 P/macros/startmusic.g			; Macro play music with steppers, indicates board started, stepper and drivers ok

;Useful G-codes
;M206 Set home offset. Could be used to adjust head above bed during printing. M206 Z0.1 move up by 0.1mm 
;M999 reset board
;M562 reset a temperature fault
;M105 get current extruder temperature
;M141 get or set chamber temperature
;G28  home
;G32  calibration standard (use macro bed.g if present or use points defined by M557)
;M302 P1  allow cold extrusion for P1 extruder
;M503 Display this config
;M577 wait an endstop trigger - see RepRap wiki
;M997 In application software upgrade - in development
;M668 Set bed errors compensation - in development - Very interesting feature to compensate non flat or temperature deformed bed

