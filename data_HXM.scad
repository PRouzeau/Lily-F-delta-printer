// Data Set for Hexagon Minimum Delta printer -HXM - 11 January 2015
// effector used HXM3
// For use with standard Fisher components
// Program license GPL 2.0
// documentation licence cc BY-SA and GFDL 1.2
// Design licence CERN OHL V1.2

part=0;
if (part) { // set part =0 (no part) for simulation
  $fn=32;
  if (part==1) foot(); //foot with elevated support, for Fisher std rods
  else if (part==2) foot2(); // base to use with wallsup (no surelevation)
  else if (part==3) wallsup();  // wall support, in conjunction with above part  
  else if (part==4) motor_support(); 
  else if (part==5) carriage();   
  else if (part==6) tensioner(); // tensioner for plain bearings
  else if (part==7) tensioner(true); // tensioner for flanged bearings  -- add a washer between bearings
  else if (part==8) rot (180) twheel(); // option: tensioner wheel
  else if (part==9) duply (10,7) arm_junction(); // arms junction
  else if (part==10) dmirrorx() tsl (28) rot (90-22.5) extruder_bracket(); // extruder plate attach 
  else if (part==20) ref_stick();  // print the reference stick  
  else if (part==30) template(); //holes in base plate to be exported to DXF
}

Delta_name = str("HXM131/500 by PRZ");
holeplay = 0.16; // added diameter to ALL cylinder (internal/external)
ballplay = 0.14; // added play to ball diameter - shall give tight socket
dia_ball = 5.96; // real ball diameter

housing_base=0; // no housing

// Data for radius 131 and height between plate 500, called HXM131/500

beam_int_radius = 131; // radius on rod axis plane - used as reference radius
reference_l = beam_int_radius*2-90; //measure distance with a reference rod 
//radius 131 correspond to reference measure of 172mm

hbase  = 0; // (=frameThk)// height of the base structure 
htop   = 0; // = htopPlate+31+frameThk; // height of top structure 31 motor bolt spacing
htotal = 426+45-13+42; // total height, below top plate, without base
echo (htotal=htotal);
sidevtext = 0; // side plate extension over top plate

bed_level = 0; 
extrusion = 0;  // stop the simulator rod module
rod_dia   = 8;  // Rod diameter
rod_space = 42; // set two rods instead of one extrusion 45 for beta, 42 for 1.0
rod_height= 426;
rod_base  = 46;

frameThk = 12;  // frame structure thickness
platethk = 18;
htopPlate = 5;
hbottomPlate = 18;

car_hor_offset= 16; 
hcar = 16; 
car_vert_dist = 4.5;
top_clearance =  5 + 46; // motor 43 // clearance between top of the carriage and top structure

eff_hor_offset= 28; 
eff_vert_dist = 0; 
arm_space= 58; // space between the arms
wire_space= 46; // space between the wires

//delta_angle = 62; 
arm_length = 190; // supersedes delta_angle  
mini_angle = 25; 
hotend_vert_dist = 31; // dist to reference plane (ball axis here)

ball_ext =1.25;
dia_arm = 3;
railthk =0; 
railwidth =0; 
rail_base=0;
frame_corner_radius=1; 
frame_face_radius= 0;
corner_offset=13;
hotend_offset = 6;
hotend_dist = 17;

belt_dist = 2;
belt_axis = 3-belt_dist;
//echo (belt_axis =belt_axis);
motor_offset = -8;

spool_diam = 200;  
$spool_rot = [0,0,0];
$spool_tsl = [80,60,htotal+18+8];

$bedDia=200; // force the bed diameter 190+16

struct_color = "Gold";
moving_color = "Lawngreen";
bed_color = "silver";
panel_color = [0.5,0.5,0.5,0.5];
//panel_color = "burlywood";

camPos=true;

$vpd=camPos?1750:$vpd;   // camera distance: work only if set outside a module
$vpr=camPos?[80,0,42]:$vpr;   // camera rotation
$vpt=camPos?[190,-67,290]:$vpt; //camera translation  */

// data specific to this printer
$ht_tens = 73; // height of tensioner frame (height of bottom of the corner)
tens_space=27; // space between tensioner screws
corner_hoffset = 20; // 35 gives 150 mm part - 40 could be obtained with laths thk 5mm
corner_hoffset2 = 18; // for the door - constant for a given rod diameter
diamNut3 = 6.1; // checked
diamNut4 = 8.1; // checked

basethk = 18;
basewd = 370; // base/top panel width 
basedp = 320; // base/top panel depth
basewoffset = 0;  // base/top panel side offset
basedpoffset = 4; // base/top panel front offset

/* Alternative dataset with same components HXM 139/500 
//  -> usable diameter 186 mm H centre ~ 225mm, periphery 215mm - base slightly enlarged
// uncommenting the block will supersede former data  
Delta_name = str("HXM139/500 by PRZ");
beam_int_radius = 139;
arm_length = 204;
mini_angle = 23; 
basewd = 380;
basedp = 340;
basedpoffset = 6;
//*/

$noTop = false;
$boxed = true;

// the door structure is recessed by 20mm to be sufficiently large to take the part out
// Also, top of door is used for filtering fumes

// side plate dimensions 
  splatewd = 150;
  splatedist = beam_int_radius+corner_offset+frame_corner_radius;
  //bplatewd = 200; // shall be calculated !!
  //bplatedist = splatedist-18; // shall be calculated !!
  rdc = sqrt(splatedist*splatedist+splatewd/2*splatewd/2);
  angle = 60-asin (splatewd/2/rdc);
  platedist = rdc *cos (angle);
  platewd = rdc *sin (angle)*2;
  $dtxt = [ // $dtxt shall be an array
    str("Sides plates: ",round(splatewd),"/",round(platewd),"/",round(basewd-30),"x",htotal, " mm"),
    str("Base plate: ",round(basedp)," x ",round(basewd)," mm"),
    str("Rod length: ",round(htotal-rod_base-28), " mm"),
    str("Threaded rods: ",round(reference_l+32+10), "/",round(reference_l+42+10)," mm"),
   "Machine licence: CERN OHL V1.2"
  ];
  
include <PRZutility.scad>  

module template() { // to locate holes for centering the structure
  rotz(-30)
    projection()
      difference() {
        rotz(30) cubez (basewd,basedp,1,  basewoffset,basedpoffset); // base plate
        rot120() {
          cylz (-4, 66,  beam_int_radius+belt_axis); // tensioner /belt access
          dmirrory() cylz (-4, 66,  splatedist+platethk/2, splatewd/2-25); // panel screws
        }  
       rotz(120) dmirrory() cylz (-4, 66,  splatedist+platethk/2, basewd/2-15-25);
        cylz (-3, 66);
        rot120() dmirrory()  
          cylz (-4,66,  beam_int_radius+7.5,22); // top support screws
      }  
} 

//*
$bCar=true; // allow the program to use below module instead of standard carriage
// $ variable does not give warning when not defined
module buildCar() { // modify to allow excentrate articulation (lowered) ??
  dcar = 15+6; // 15 is bearing diam LM8UU = d15x24 - LM10UU d19x29 - LM12UU d21x30
 * color(moving_color)
  tsl (0,0,-car_vert_dist) {
    hull () 
      dmirrorx()
        cylz (-dcar,hcar,  rod_space/2,0,car_vert_dist-hcar/2); // -x to decrease side size
    cubez (rod_space-rod_dia,20,-dia_ball*1.5,  0,10-car_hor_offset,dia_ball*1.5/2);
    cylx (-dia_ball*1.5,rod_space-rod_dia,  0,-car_hor_offset); 
  }
  color(moving_color)
    mirrorz() carriage();
  color ("silver") { // linear bearings LM8UU & LM8LUU
    cylz (-15,24, rod_space/2,0,-7.5);
    cylz (-15,45, -rod_space/2,0,-7.5-10.5);
  }
} //*/

$bSide = true; // setup the below side panel *in addition* to frame
module buildSides() {
  rodrd = rod_space/2+4;
  rodht = -10;
     // motor support 
    rot120() tsl (0,beam_int_radius,htotal-23) {
      color(struct_color)  
        motor_support();
      color("grey")    
        tsl (rodrd,7,rodht)
          rotz(30) { 
            cyly (5,-220,      0,5,-2);
            cyly (5,-212,      12,0, -htotal+23+10+5);
          } 
      *color("red") //measurement for rod length  172 for beam_int_radius 131
        tsl (rodrd+5.5,8,-16)
          rotz(30)  
            cyly (3,-172,    0,-19.1);
    }  
    holed =25;
    color (panel_color) {
      for (i=[30, 120+30])
        rotz(i) 
          cubez (platethk, splatewd, htotal+sidevtext, -splatedist-platethk/2); 
      rotz(-90) 
          cubez (platethk, basewd-30, htotal+sidevtext, -splatedist-platethk/2); 
    }
    if ($boxed)
      color (panel_color) 
        drotz (-120)
        rotz (-30) 
          //cubez (platethk, platewd+2*platethk, htotal+sidevtext, -platedist-platethk/2-platethk/2); // 2nd offset to clear other panel
       cubez (platethk, platewd, htotal+sidevtext, -platedist-platethk/2); // 2nd offset to clear other panel
   if (!$noTop)  // at the end for transparency
      //hexagon (frame_corner_radius+20, rod_space, beam_int_radius, corner_offset,corner_hoffset, htopPlate, htotal); //??
    color (panel_color)  cubez (basewd,basedp,basethk, basewoffset,basedpoffset, htotal); // top plate  
}

$bAllFrame=true;
module buildAllFrame() {
  color("lightgrey") 
    cubez (basewd,basedp,-basethk, basewoffset,basedpoffset); // base plate
  color(struct_color) {
    rot120() tsl (0,beam_int_radius,0) foot(); 
    rot120 (-30)  
      tsl (beam_int_radius,0,$ht_tens) {
        tensioner(); 
        tsl (0,0,-12) twheel();
      }  
  } 
  color ("grey") {
    rot120 (-30) {
      rotz(30) 
        tsl (0,beam_int_radius+motor_offset,htotal-23) // motor
          rot(-90) nema17(32);   
      dmirrory()  //rods
        cylz (rod_dia,rod_height,   beam_int_radius,rod_space/2,rod_base); 
    }
  } 
  tsl (22,38,htotal-120)
    rot (0,-55) {
      color ("white")  tore (4,240,  200,300);
      color ("blue")   tore (10,240, 300,304);
      color ("yellow") tore (2,240,  -60,0);
    }   
  rotz (-90) 
    tsl (beam_int_radius-65,25,htotal-125) {
        rot (0,90) {
          nema17(32); // ??
          tsl (0,0,4) 
            color("red") mirror ([0,1,0]) rotz(-55) import ("extruder.stl");
        }  
    }
   *dimcheck(); 
}

module dimcheck() { // check dimensions
  rotz (120)
  color("red") {   
    cyly (-3,66, 0,beam_int_radius,10); // centering hole
    cyly (-3,66, 0,beam_int_radius,htotal-23+15); // centering hole
    echo ("motor center pin height:", htotal-23+15); // presently 447
  }  
}

module tensioner(flanged=false) { // build pulley tensioner
htTens=15; // flanged bearing needs a washer between flanges, so add width
intspace = (flanged)?9:8; // space between internal faces
axis_h = htTens/2+1;  
  difference() {
    tsl (belt_axis) {
      hull() {
        dmirrorx() dmirrory()
          cylz (5,htTens,  6, 8.5); 
        cylz  (rod_dia+5,htTens+4,  -belt_axis,-rod_space/2, -4);
        cylz (16,-1,  0,0, -3);
      }
      dmirrorx() 
        tsl (8.5,0,axis_h)
          rot(0,90) cylinder (d2=8, d1=17, h=3.8);
    }  //::: then whats removed :::
    tsl (belt_axis) 
      hull()  {
        dmirrorx() dmirrory()
          cylz (1.5,axis_h+4,  5, 8.3, htTens/2-3); // belt hole
        dmirrory() 
          cylx (-1,10, 0,4,0); 
        cylz (10.6,33,  0,0, -1.5); 
        cylz (rod_dia+1.5,33,  -belt_axis,-rod_space/2, -1.5); // rod guide
      } 
    cylx (-3,55,  0,0,axis_h); // bearing hole
    tsl (-11+belt_axis,0,axis_h)
      rot(0,-90) cylinder (d2=6.5, d1=3, h=1.4); 
    tsl (9.5+belt_axis,0,axis_h)  
      rot (30) cylx (diamNut3, 3.2, 0,0,0, 6);  
    cylz (-rod_dia,55,  0,-rod_space/2); // rod guide
    cylz (4.2,-30,  belt_axis); // hole for tensioner bolt
    cubez (100,100,10, 0,0,htTens); // Top cut - for bearing cones 
  }  
  difference() {
    tsl (belt_axis) 
      dmirrorx() 
        tsl (intspace/2,0,axis_h)
          rot(0,90) cylinder (d1=5.5, d2=13, h=2.3);
    cylx (-3,55,  0,0,axis_h); // bearing hole
  } 
  difference() {
    cylz (rod_dia+5,htTens+4,  0,-rod_space/2, -4);
    cylz (-rod_dia,55,           0,-rod_space/2); // rod guide
  }
  if (!flanged)
    tsl (belt_axis)
      dmirrorx() //belt side stops - if bearings not flanged - cut for flanged bearings
        difference() {
          hull() {
            cubez (3,14.5,-2, 3.5+1.5,0,htTens);
            cubez (2,14.5,-1, 6+1,0,htTens-5);
          }
          cubez (2,6,-5, 4.2-1,0,htTens+0.1);
        }  
  *color("grey") cylx (-3,25,  belt_axis,0,axis_h); // bearing hole 
}

//tsl (400) fan_guard();

$bEffector=true;
//$chimera =true;
module buildEffector() {
  if  ($chimera) {
    color ("yellow")
      rotz(-90) 
        tsl (0,0,4) 
          rot(180) 
          import("duct_Chimera.stl");
    color ("black") rotz(-90) {
      tsl (-15,0,38+4) // part fan
        build_fan(30,10);
      tsl (19,0,38-15+4) // hotend fan
        rot(0,90) build_fan(30,10); 
    }  
  }
  else {
    *color ("yellow")
      tsl (0,0,eff_height) 
        rot(180) 
        import("duct_dual_Hexagon.stl");
    color (moving_color) {
      import("HXM_effector.stl");
      rotz(60) tsl (0,0,1)
        import("HXM_hotsup.stl");
    }  
   * tsl (0,0,25) {
      rotz (180) tsl (0,25,-2)   rot(-90) build_fan(30,6);
      rotz (60)  tsl (0,22.5,-2) rot(-80) build_fan(30,6);
      rotz (300) tsl (0,22.5,-2) rot(-80) build_fan(30,6);
    }
  }
}

$bHotend=true;
module buildHotend() {
  color("silver")
  if ($chimera) {
    rotz(-90)
      tsl (10,0,27)
        rot(90,0,90)
          import("Chimera_x.stl");  
  }
  else
   // dmirrorx() 
     // tsl (hotend_dist/2,-hotend_offset,-8.4) 
       * rotz (90) import("Hexagon-102.stl");
}

module twheel() {
  difference() {
    union() {
      hull() {
        cylz (9.5,6);  
        cylz (14,2, 0,0,4);  
      }  
      for (i=[0:3])
        rotz (i*90) 
          hull() {
             cylz (8,5, 0,0,1);
             cylz (2.8,2, 10,0,4);
          }  
    }
    cylz (diamNut4, 5, 0,0,2.8, 6);
    hull () {  
      cylz (diamNut4, 5, 0,0,5.5, 6);
      cylz (12, 1, 0,0,10);
    }  
    cylz (-4, 22);
  }  
}

// Tests 
*rotz (120)  cylz (working_dia,30,-beam_int_radius+20); //check access through door
*color (moving_color) frame_int (frame_corner_radius,rod_space, beam_int_radius,18,80);
*cylz (325,10,0,0,0,150); // checking enveloping cylinder
*cylz (264,10,0,0,0,100); // checking internal cylinder


//== extract from library ================================================

module tore (dia, ldia, angstart, angend, qual=100) { // first diam is small diam
  sectorz (angstart,angend, -ldia*2)
    rotate_extrude ($fn=qual)
      tsl (ldia/2)
         circle (dia/2);
}
//tore (10, 50, 220, 290);

module cylsectz (di, height, thickness, angstart,angend) { // cylindrical sector
  sectorz (angstart,angend)
    difference () {
      cylz (di+2*thickness, height,0,0,0,120);
      cylz (di, height+2,0,0,-1,120);
    }  
}

//cylsectz  (100,25,10,100,160);

module sectorz (angstart,angend, radius=-1000,depth=2000 ) { //cut a sector in any shape, z axis  
  // negative radius will equilibrate the depth on z axis
  // angstart could be negative, angend could not
mvz = radius<0?-abs(depth)/2:depth<0?depth:0;  
sectang =  angend-angstart;
cutang = 360-sectang; 
  module cutcube() { 
    tsl (-0.02,-abs(radius),mvz-0.1)  
      cube(size= [abs(radius),abs(radius),abs(depth)], center =false);
  }  
  module cutsect () {
    if (sectang >270) {
      difference () {
        cutcube();
        rotz (-cutang) 
          cutcube();
      }
    }  
    else {
      cutcube();
      rotz (-cutang+90) 
        cutcube();
      if (cutang > 180) 
        rotz(-90) 
          cutcube();
      if (cutang > 270)   
        rotz(-180) 
          cutcube();
    }
  } // cutsect
  difference () {
    children();
    rotz (angstart) 
      cutsect();
  }
}

module cut_rodface() { //cut rod support face - shall be same cut for top and bottom support to have same rod length
  rotz(30) // cut rod face 
        cubey (50,-10,50, 40,-28,-1);
}

module foot2() {
  rod_base  = 0.8;
  htr = 10; // rod insertion height
  rod_hold = rod_dia+7;
  scr = (htr-rod_base)/2+rod_base; // screw height
  wall_space = 100;
  offsety = motor_offset+0.5;
  rodrd = rod_space/2+4;
  rodht = 5;
  dec = 12;
  rodextend = 6.5;
  fix_space = 66;
  
  difference() { 
    union() {
      dmirrorx() {
        hull() { // rods ends
          cyly (8.5,14-offsety,     16,offsety,scr); // fix holes
          cubey(2,12-offsety,scr+6,  rod_space/2-2,offsety+2,(scr+6)/2);
          cylz (rod_hold,htr-rod_base-2,   rod_space/2,0,rod_base+2);  
          cylz (12,1,                rod_space/2);       
          cylz (12,9,  fix_space/2,0);
        } 
        tsl (rodrd,7)
          hull() // triangle rods extension
            rotz(30) {
              cyly (10,10.5+rodextend,    dec,2-16.5-rodextend, rodht);  
              cyly (10,10.5,    dec-6,2-16.5+1, rodht);  
              cubey (6,10.5+rodextend,2,  dec,2-16.5-rodextend,1); 
              cubey (6,rodextend,4,  dec-4,2-16.5-rodextend,2); 
              cubey (6,2,4,  dec-4-7,2-16.5+2,2); 
            }
        hull() {
          cyly (12,-0.1, wall_space/2,14,6);  
          cylz (1,12,   wall_space/2,11);   
          cubey (10,8,2, wall_space/2-8,6,1);
          cylz (12,9,  fix_space/2,0);
        } 
        cyly (12,-3.5,     wall_space/2,14,6);  
      } 
      cubez (40,2,scr+6,  0,13,0); // top face
      cubey (82,14-offsety,2.5,  0,offsety,1.25); // bottom
      cubey (wall_space+6,-3.5,2.4,  0,14,1.2); // bottom
      cconez (15,11,2,4.5, 0,belt_axis);
    } //::: then whats removed :::
    dmirrorx()  {
      cylz (rod_dia,25, rod_space/2,0,rod_base);
      cyly (-4,66, 16,0,scr); //wall fix holes
      cyly (-4,14, wall_space/2,8,6);
      cconey (9.5,1,-5.5,-4.5, wall_space/2,6,6);
      hull() {
        cylz (1.5, 25, rod_space/2-1,0,-1);
        cylz (1.5, 25, rod_space/2-12,0,-1);
      }
      cylz (-4,66,  fix_space/2,0); // floor attach
      cconez (10,4, -2.5,-10,  fix_space/2,0, 10); 
      tsl (rodrd,7,rodht)
        rotz(30) {
          cyly (-5,99,  dec);
          tsl (dec)
            hull() {
              cylz (4,33,  8,-3,-10);
              cylz (10,33 ,  -7,0,-10);
              cylz (16,1,  -dec+4,15  ,-1-rodht);
              cylz (16,33,  -dec+15,22.5  ,-10);
            }  
        }
        cut_rodface();  
    } 
    cylz (-4,33, 0,belt_axis);
    cylz (diamNut4,3.5, 0,belt_axis,-0.1, 6);
    cubey (100,10,100, 0,14); // cut face
    cyly (3,20, 0,10,6); // positioning hole
  }  
}

module wallsup() {
  rod_base  = 0;
  htr = 10; // rod insertion height
  scr = (htr-rod_base)/2+rod_base; // screw height
  offsety = motor_offset+0.5;
  rod_hold = rod_dia+7;
  difference() { 
    union() {
      dmirrorx() {
        hull() { // rods ends
          cyly (8.5,14-offsety,     16,offsety,scr); // fix holes
          cubey(2,  12-offsety,htr,  rod_space/2-2,offsety+4,htr/2);
          cylz (rod_hold,htr,        rod_space/2);  
          cylz (12,1,                rod_space/2);       
        } 
      } 
      cubez (rod_space,2,htr,  0,13,0);   // wall face
      cubez (rod_space,2,htr,  0,1-rod_hold/2,0); // reinf
      cubey (rod_space,14-offsety,2.5,  0,offsety,1.25); // bottom
    } //::: then whats removed :::
    dmirrorx()  {
      cylz (rod_dia,25, rod_space/2,0,-1);
      cyly (-4,66, 16,0,scr); //wall fix holes
      hull() {
        cylz (1.5, 25, rod_space/2-1,0,-1);
        cylz (1.5, 25, rod_space/2-10.5,0,-1);
      }
    } 
    hull() 
      tsl (0,belt_axis) 
        dmirrorx() dmirrory() 
          cylz (-3,33, 6,4,-10);
    cubey (100,10,100, 0,14); // cut face
    cyly (3,20, 0,10,6); // positioning hole
  }  
}



module foot() {
  rod_base = 49;
  wall_space = 52;
  fix_space = 64;
  offsety = motor_offset+0.5;
  rod_hold = rod_dia+6.5;
  rodrd = rod_space/2+4;
  rodht = 5;
  dec = 12;
  rodextend = 6.5;
  htr = 18;
  scr = htr/2+rod_base;
  difference() { 
    union() {
      dmirrorx() {
        hull() { // rods ends
          cyly (8.5,14-offsety,     15,offsety,scr); // fix holes
          cubey(1,12-offsety,htr-6, rod_space/2-3.5,offsety+2,rod_base+htr/2+1);
          cylz (rod_hold,htr-2,     rod_space/2, 0,         rod_base+2);  
          cylz (1.6,1,              rod_space/2, 0,         rod_base-14);    
        } 
        hull() { // rods ends fins
          cylz (1.6,1, rod_space/2, 0,          rod_base-14);   
          cylz (1.6,1, rod_space/2-1.8,   6.6,          0);   
          cylz (1.6,rod_base+12, rod_space/2-3.5, -offsety+5, 0);       
        }  
        tsl (rodrd,7)
          hull() // triangle rods extension
            rotz(30) {
              cyly  (10,10.5+rodextend,   dec, 2-16.5-rodextend, rodht);  
              cubey (6,10.5+rodextend,2,  dec, 2-16.5-rodextend, 1); 
              cubey (6,rodextend,4,       dec-4,2-16.5-rodextend,2); 
            }
       hull() {
          cyly (2,1,     12,13,1);
          cylz (12,6,  fix_space/2,1);
          cubez (20, 2,2.5, 25,13);
          cubez (10, 2,6, 30,13);
        } 
        hull() {
          cconey(15,10, -3.5,1.6,  wall_space/2,14,10.5);
          cubey (15,-3.5,2.4,      wall_space/2,14,1.2); // bottom 
        }  
      } 
      difference() {
        hull() {
          cubez (37,1.6,rod_base+htr-2,  0,13.2,0); // top face
          cubez (60,1.6,1,  0,13.2,0); // top face
        }  
        cyly (100,8, 0,10,rod_base+64, 60);
      }  
      difference() {
        hull() {
          cubez (40, 1.6,htr-8,  0,-6.6,rod_base+4); // top face
          cubez (8,2.6,1,  0,-6.5,0); // top face
        }
        cyly (100,8, 0,-13.5,rod_base+61, 60);
      }
      cubey (79.6,-22.66,2.4,  0,14,1.2); // bottom
      cconez (15,11,2,4.5, 0,belt_axis);
    } //::: then whats removed :::

    dmirrorx()  {
      cylz (rod_dia,25, rod_space/2,0,rod_base);
      cyly (-4,66, 15,0,scr); //wall fix holes
      cone3y (9.4,4,-15,-2,8, wall_space/2,10.9,10.5);
      hull() { // cut rod supports
         cylx (1.5, -25, rod_space/2-1,0,rod_base-1.5);
         cylx (1.5, -25, rod_space/2-1,0,rod_base+25);
      }
      cylz (-4,66, fix_space/2,1,-1); // floor attach
      cconez (10,4, -2.5,-5,  fix_space/2,1, 6); 
      
      tsl (rodrd,7,rodht) // biased cut for triangle rods seats
        rotz(30) {
          cyly (-5,22,  dec, -12);
          tsl (dec)
            hull() {
              cylz (2,33,  8.5,-4,-10);
              cylz (2,33 , -4,-4,-10);
              cylz (2,33,  -4,-1.5  ,-10);
              cylz (1,33,  14,15  ,-10);
            }  
        }
    } 
    cylz (-4,33, 0,belt_axis); // tensioning nut hole
    cylz (diamNut4,3.5, 0,belt_axis,-0.1, 6);
    cubey (150,10,150, 0,14); // cut face
    duplz (40)
      cyly (-3,44, 0,10,10); // positioning hole
  }  
}



module motor_support() {
  offsety = motor_offset;
  rodrd = rod_space/2+5;
  rodht = -12;
  rodextend = 6;
  dec=0;
  sfloor = -20;
  difference() { 
    union() {
      dmirrorx() {
        //dmirrorz() 
        hull() {
          cyly (8,14-offsety, 31/2,offsety,31/2); // motor holes
          cyly (2,14-offsety, 31/2,offsety,10); // motor holes
        }
        cyly (8,14-offsety, 31/2,offsety,-31/2); // motor holes
        
        cubey (3,14-offsety,38,  15,offsety,38/2+sfloor); // sides
        cubey (3,7-offsety,40,   15,offsety+9,40/2+sfloor); // sides
        hull() { // rods ends
          cylz (15,-15,  rod_space/2,0   ,-4.25);         
          cubey (2,14-offsety,-15,     16,offsety,-7.5+sfloor);
          tsl (rodrd,7,rodht)
            rotz(30) {
              cyly (10,-16.5,      0,2);
              cubey(3,-6.5,2,     0,0,1+sfloor-rodht); 
            }  
        } 
        tsl (rodrd,7)
          hull() // triangle rods extension
            rotz(30) {
              cyly (10,10.5+rodextend,    dec,2-16.5-rodextend, rodht);  
              cyly (10,5,    dec-8.5,2-16.5+6, rodht);  
              cubey (3,10.5+rodextend,2,  dec,2-16.5-rodextend,1+sfloor); 
              cubey (4,2,4,  dec-4-8,2-16.5+6.7,2+sfloor); 
            }
      }      
      cubey (33,2,23,  0,12,11.5); // top face
      cubey (33,2,19,  0,-8,10); // top face
      hull() { // bottom
        cubey (32,14-offsety,4,  0,offsety,sfloor+2); 
        dmirrorx ()
          cylz (15,4,  rod_space/2,0   ,sfloor);
      }  
      dmirrorx() { // gussets
        duply (-11.5)
          hull() {
            cubez (13.5,2,4,   20.25,13,19);
            cubez (3,2,3,   15,13,3);
          }  
        cubez (13.5,11.5,3.5,   20.25,6.75,19.5); // top fixations
      }  
    } //::: then whats removed :::
    cylz   (-4,66,      -10, 9.5); // switch actuation
    cconez (5,4,1.6,6,  -10, 9.5, -26);
    dmirrorx()  {
      cylz (-rod_dia,22, rod_space/2,0,-14);
      cylz (4,33,  22,7.5,0); // top holes
      tsl (22,7.5,9.5)
        rotz(30) cylz (diamNut4,10,  0,0,0, 6); // top holes
      dmirrorz() cyly (-3.6,66, 31/2,0,31/2); // motor fix holes
      cubez (15,0.8,22, 13,0,-23); // cut
      tsl (rodrd,7,rodht)
        rotz(30) {
          cyly (-5,99);
          hull() {
            cconey (11,6,6,5,  0,1);
            cyly   (8,6,   5,1,8);
            cyly   (2,20,  5,40,50);
            cyly   (10,6,  8,1,-6);
          }  
        }
      cut_rodface();
    }  
    hull() { // central hole
      dmirrorx() {
        cyly (-2, 66, 5,   0, 10.5);    
        cyly (-2, 66, 12.5,0,0.5);    
      }
    }
    hull() 
      tsl (0.5,belt_axis) 
        dmirrorx() dmirrory() 
          cylz (-3,33, 6.5,4,-10);
    cyly (22.5, 2.5, 0,-10); // central hole
    cubey (100,10,100, 0,14); // cut panel face
    cyly (-3,22, 0,10,18); // cut centering hole
  }  
}

module carriage() {
  belt_side = 5.5;
  carht = 16;
  offsety = -10;
  rodrd = rod_space/2+4;
  rodht = 5;
  dec = 10;
  rodextend = 6;
  module cutx() {
    dmirrorx() 
      tsl (9,-belt_dist-4.5,-1) {
        rotz (45) cubez (10,1.5,20, 5); 
        cylz (1.5, 20); 
      }  
    cubez (18,1.5,20, 0,-belt_dist-4.5,-1); // cut
    cyly (-3,66, 0,0,carht/2); //pinch hole  
    cylz (-2,66, 9,belt_axis,carht/2); //hole to lock belt if needed    
  }
  difference() { 
    union() {
      dmirrorx() 
        cylz (23,carht,      rod_space/2,0,0, 60); 
      hull() {
        cylz (7,carht, 10, 9.5); // switch actuation
        cubez (12,1,carht, 10,8); // 
      }  
      *color ("grey")  cylz (-3,999, 10, 9.5); // switch actuation      
      hull() {
        cubez (42,22,carht,  0,-0.5,0); // top face
        cubez (18,20,carht,  0,-belt_dist-2.50); 
      }  
      tsl (0,-12.45-belt_dist,carht/2)
        rot(90) cylinder (d2=9, d1=18, h=2);
    } //::: then whats removed :::
    cutx();
    tsl (0,10.7,carht/2)
      rot(90) cylinder (d2=6.5, d1=12.5, h=1.2);
    cconez (3.2,2.6, 5,20,  10, 9.5,-1); // switch actuation
    cconez (3.2,2.6, 5,20,  3.5,-11,-0.1); // stop fixation
    dmirrorx() { 
      cylz (15,22, rod_space/2,0,-0.1);
      
    }  
    cylz (-9.5,33, -belt_side,belt_axis);
    tsl (0,belt_axis) { // belt anchoring hole
      hull() 
        dmirrory ()
          cylz (-2,33, belt_side,3.4,-0.1);
      hull() 
        dmirrory () {
          cylz (2,1, belt_side,3.4,carht/2+1);
          cylz (4,0.1, belt_side,3.4,carht);
        }
      hull() 
        dmirrory () {
          cylz (2.8,0.1, belt_side,3.4, -0.1);
          cylz (2,0.1, belt_side,3.4,0.5);
        }  
      }
      duplz (carht+10) // cut top/bottom (cone)
        cubez (50,100,-10);
  }  
  
  dmirrorx () 
    difference() {
       hull () {
          cylz (22.5,9.5, rod_space/2,0);
          cylz (11,5, arm_space/2,-car_hor_offset+1);
          cylz (6.5,5, wire_space/2,-car_hor_offset+1);
       }  
       tsl (arm_space/2,-car_hor_offset, car_vert_dist) {
         rot (35) {
           cubez (40,15,10, 0,0,ball_ext);  // ball plane cut
           cconez (2,5, 2,-20, wire_space/2-arm_space/2); 
         }  
         sphere(dia_ball/2+ballplay/2, $fn=40);    
       } 
       cylz (15,22, rod_space/2,0,-1); 
       cylz (-9.5,33, belt_side,belt_axis); // belt passage
       cutx();
    }
}

module oldmotor_support() { // other print orientation - abandoned yet
  offsety = motor_offset;
  rodrd = rod_space/2+4;
  rodht = -10;
  difference() { 
    union() {
      dmirrorx() {
        dmirrorz() cyly (7.5,13-offsety, 31/2,offsety,31/2); // motor holes
        cubey (3,13-offsety,38,  31/2,offsety,1.5); // sides
        tsl (rodrd,7,rodht)
          rotz(30) {
            hull() {
              cyly (12,-14,      0,2);
              cyly (12,-14,      0,2,5);
              cyly (12,-14,      0,2,-5);
            }  
          }  
        hull() { // rods ends
          cylz (15,-15,  rod_space/2,0   ,-2.5);         
          cubez (6,1,-15,         19,12.5,-2.5);
        } 
      } 
      hull() {
        cubey (46,3,3,  0,10,20+1.5); // top face
        cubey (34.5,3,4,  0,10,14);
      }  
      cubey (32,21,3,  0,offsety,-15.5);
      hull() {
        dmirrorx()
          cylz (10,3,   22,6   ,20); // top supports
        cubez (46,3,3,   0,11.5,20);
      }  
    } //::: then whats removed :::
    dmirrorx()  {
      cylz (-rod_dia,33, rod_space/2,0,-10);
      cylz (4,33,  22,6,0); // top holes
      cylz (9,10,  22,6,10); // top holes
      dmirrorz() cyly (-3,66, 31/2,0,31/2); // motor fix holes
      tsl (rodrd,7,rodht)
        rotz(30) {
          cyly (-5,99);
          hull() {
            cyly (12,15, 0,2);
            cubey (10,15,12, 5,2);
          }  
        }
    }  
    hull() 
      tsl (0,belt_axis) 
        dmirrorx() dmirrory() 
          cylz (-3,33, 6,4,-10);
    cyly (22.5, 2.5, 0,-10); // central hole
    cubey (100,10,100, 0,13); // cut face
  }  
  dmirrorx()
    difference() {
       cyly (13.5, -5, 24, 13,-10);
       cyly (11.5, -10, 24, 16,-10);
       cubey (10,-15,15,  20,16, -10);
       cubey (100,10,100, 0,13); // cut face
    } 
}

module arm_junction() { // arm connexion for M3 threaded rods
  difference() { 
    union() {
      hull() {
        cylx (-7,12);
        cylx (-6,35);
      }  
      cubez (35,5,6, 0,0,-3);
    }
    dmirrorz() 
      cubez (40,10,5, 0,0,-8);
    dmirrorx() 
      cconex (2.6,3, 1,15.5, 1.2);
  }  
}

module switchbase () { // design to be finalized
  difference() {  
    union() {
      cylz (8,5,        -10, 9.5);
      cubez (3,10,18,   -6.5, 19); 
      hull() { 
         cylz (8,3.5,  -10, 9.5);
         cylz (7,3.5,   -4, 11); 
      }  
      hull() { 
        cylz (7,3.5,   -4, 11);
        cylz (10,3.5,    0, 15); //
        cubez (3,15,3.5, -6.5, 15.5); 
      }  
    } 
    cconez(3.5,5,-2,6,  -10, 9.5, 7.9);  
    cconez (4,9, 2,1.8, 0,15,-0.1); 
    duplz (10)
      cylx (2, -20, 0,21,5);
  }
}

*tsl (0,0,25) 
   switchbase ();


module ref_stick() { // reference for triangle assembly
  difference() {
    cubez (reference_l, 8,6);
    cubez (reference_l-6, 5,6, 0,0,1.5);
  }
}

module extruder_bracket() {
  hta = 40;
  difference() {
    union() {
      rot(22.5) {
        cubez (19,2.8,hta, -9.5, 1.4);
        duplz (hta-12) 
          cyly (12,2.8, -19,0, 6);
      }  
      rotz(60)
        rot (0,-25.5) {
          cubez (11,2.5,hta-5,  5,1.25, 2.5); 
          duplz (hta-12)
            hull() 
              duplx (-5)
                cconey (12,8, 1.5,2.5,  7,0, 6);
        }  
    } //::: then whats removed :::
    rot (22.5) {
      duplz (hta-12) 
        //cconey (3.2,7, -2,-6, -19,1.9, 6);
        cyly (-3.2,66, -19,0, 6);
        
      hull() 
        duplx (-5) duplz (hta-38)
          cyly (-15,66, -18,0,19); 
      cubez (100,20,100, 6,-10, -10); 
    }  
    rotz(60)
      rot (0,-25.5) {
        duplz (hta-12)
          cconey (3.2,7, 1.5,2.7,  7,-0.1, 6);
        cubez (100,20,100, 6, -10); 
        hull() 
          duplz (hta-34)
            cyly (-19.5,66, 18,0, 17, 32); 
      }   
  }   
}

module bowdlg () { // bowden extension - normally not needed
 difference() { 
    union() {
      hull() {
        cylx (-12,12);
        cylx (-6,26);
      }  
      cubez (26,6.5,8, 0,0,-4);
    }
    dmirrorz() 
      cubez (40,10,5, 0,0,-8.5);
    dmirrorx()  {
      cconex (4,4.5, 1,16,  0.5);
      hull() 
        duplz (15)
          cylx (diamNut4, 3.3, 2.5,0,0, 6); 
    } 
    cylx (-2,66); 
  }    
}

module nema17(lg=40) { // NEMA 17 stepper motor. - replace by STL ??
  color("grey")
    difference() {
      union() {
        intersection() {
          cubez(42.2, 42.2, lg,0,0,-lg);
          cylz(50.1,lg+1,0,0,-lg-0.5,60);
        }
        cylz(22,2,0,0,0,32);
        cylz(5,24,0,0,0,24);
      }
      for (a = [0:90:359]) 
        rotz(a) cylz(-3,10, 15.5,15.5);
    }
}

