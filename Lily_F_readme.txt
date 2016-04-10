"Lily" delta printer built with strong wooden box structure and equipped with filters
This version 'F' is based upon parts salvaged from a RRP Fisher.
To see the simulation of printer, run the "Delta_simulator.scad" in OpenScad
The parameters of this simulation are defined in "data_Lily_F.scad"
effector simulation use stl files created in "Effector_Lily_F.scad" 
To creates STL file, define a part Number in "data_Lily_F.scad" in OpenScad
To creates STL files for the effector, define a part Number in "Effector_Lily_F.scad" in OpenScad

The default dimensions are now for a 139/500 printer, with a usable diameter of 186mm, which is 
appropriate for a 200mm bed. The loss of height is very low (less than 3mm). 
This slightly larger size gives a bit more room for fan and filter installation and makes
assembly a bit easier. Note that photos are for a printer 131/500. 
To add a base support, uncomment in the file "data_Lily_F.scad" (after existing data):  
htsub=220; $spool_tsl = [92,40,-125];
and regenerate panels 52 (back), 61 (bottom),62 (mid), 63.
base panel dimensions are given in console messages. 
Extruder shall be installed on panel side, below filter. You may modify filter fan position.

The parts and instructions for Geared extruder is in the main directory 'Geared Extruder'
If you decide to have a stool below the printer, you may want to use direct drives which are
designed to be installed on the panel sides. Use long motors (60mm).
The parts and instructions for direct drive extruder installed on side panels is in the main
directory 'Bowden Extruder Direct Drive'.
I now recommend spool supports with horizontal axis (on Spigot), having too much unwinding 
problems with vertical axis supports (loop falls, then cross and make knots). 
Spigot file is in the STL directory.

There is a libre office calc sheet which generate automatically batch for part generation. 
It is useful if you want to modify dimensions or parameters. 
You can either change parameters in the batch generator or in the scad file.

Generated batch are for Windows, but Linux or MAC users may modify them to operate on their system.

The generation of file is notably faster than with the GUI, but it may however take some time and
there is no notice of the end of the process. Command windows stay open to have a look on the
error messages. 

Read the presentation and assembly manual for details

references
https://github.com/Prouzeau/HXM-delta-printer
https://github.com/PRouzeau/Geared-Extruder
https://github.com/PRouzeau/Bowden-extruder-direct-drive
http://rouzeau.net/Print3D/Lily
http://rouzeau.net/twg/index.php?twg_album=3DPrint%2FLily Photos Gallery

and details how to manipulate the printer simulation are in 
https://github.com/PRouzeau/OpenSCAD-Delta-Simulator

Recent versions of OpenSCAD are needed, prefer the development snapshots:
http://www.openscad.org/downloads.html#snapshots

(c)2016 Pierre ROUZEAU  machine Licence CERN OHL V1.2. Documentation CC BY-SA 