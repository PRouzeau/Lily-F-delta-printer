; Load filament
T0
M116
G1 E450 F3600 ; bowden shortened from 460 to 390, so fast extrusion from 450 to 400
G1 E30  F100
M84 P3 E0:1		; turn extruder motors off so the user can feed by hand
T99
