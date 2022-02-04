//
// 67 mm holder for Samyang 12/2.0 lens
// Copyright (C) 2021 Uwe Glässner
//

// bayonett diameter (mm)
bay_d = 73.5;    

// bayonett wall thickness (mm)
bay_w = 3;

// bayonett rim size (mm)
bay_r = 5;

// height of bayonett (mm)
bay_h = 6;     

rim_r1 = (bay_d + bay_w)/2;
rim_r2 = (bay_d + bay_w + bay_r)/2;

// filter plate
plate_w = 85;
plate_d = 80;
plate_h = 6;

D = 0.01; // generic overlap of parts.

module rail(startwinkel, winkel, offset, height, thickness, roffset=0){
  // startwinkel = starting angle of rail
  // winkel = angle how far the rail extends
  // offset = offset of the rail from the bottom bayonett
  // height = height of rail
  // thickness = thickness of rail
  // roffset Set in case the rail is not at bayonett surface e.g. to carve out
    
  rotate([0,0,startwinkel]) {
     rotate_extrude(angle = winkel, $fn=100)
     translate([bay_d/2-thickness+roffset+D,offset,-D])
     square([thickness,height]);
     }
}
    
 difference(){
    
    union(){
       // rim
       translate([0,0,0]) cylinder(r1=rim_r1, r2=rim_r2, h=bay_h/2-0.5, $fn=100);
       translate([0,0,bay_h/2-0.5]) cylinder(r=rim_r2, h=1, $fn=100);
       translate([0,0,bay_h/2+0.5]) cylinder(r1=rim_r2, r2=rim_r1, h=bay_h/2-0.5, $fn=100);
       // outer cylinder 
       translate([0,0,0]) cylinder(d=bay_d+bay_w, h=bay_h, $fn=100);
    }
    // riffelung
    for (i=[0:60])
       rotate([0, 0, 360 / 60 * i]) translate([0,rim_r2, 0 ])
       cylinder(d=3, h=plate_h+2*D, $fn=100);
    // inner cylinder
    translate([0,0,-D]) cylinder(d=bay_d, h=bay_h+2*D, $fn=100);
    
};

rail (     0,  5, 0, 1.75, 1.2); // 0.2mm bump at the beginning
rail (     0, 73, 0, 1.75, 1.0); // main rail
rail (   +68,  5, 0, 1.75, 1.2); // 0.2mm bump at the end
rail (    -5,1.5, 0, 1.75, 0.8); // bump 3mm besides the rail to lock

rail ( 90   ,  5, 3, 1.75, 1.2); // 0.2mm bump at the beginning
rail ( 90   , 73, 3, 1.75, 1.0); // main rail
rail ( 90+68,  5, 3, 1.75, 1.2); // 0.2mm bump at the end
rail ( 90 -5,1.5, 3, 1.75, 0.8); // bump 3mm besides the rail to lock

rail (180   ,  5, 0, 1.75, 1.2); // 0.2mm bump at the beginning
rail (180   , 73, 0, 1.75, 1.0); // main rail
rail (180+68,  5, 0, 1.75, 1.2); // 0.2mm bump at the end
rail (180 -5,1.5, 0, 1.75, 0.8); // bump 3mm besides the rail to lock

rail (270   ,  5, 3, 1.75, 1.2); // 0.2mm bump at the beginning
rail (270   , 73, 3, 1.75, 1.0); // main rail
rail (270+68,  5, 3, 1.75, 1.2); // 0.2mm bump at the end
rail (270 -5,1.5, 3, 1.75, 0.8); // bump 3mm besides the rail to lock