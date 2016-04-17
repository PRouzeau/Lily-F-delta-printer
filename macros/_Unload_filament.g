; Unload filament
T0; select tool
;M109 S100	
G1 E-470 F3600 ; bowden shortened from  so unload length modified from 460 to 390
M84 E0
M84 P3 E0:1 ; turn extruder motor off - added to the standard macro
T99 ; deselect tool