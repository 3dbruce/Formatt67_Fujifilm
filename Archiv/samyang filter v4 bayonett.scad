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

module schiene(winkel,hoehe){

// main rail
rotate([0,0,winkel-36.5]) {
    rotate_extrude(angle = 73, $fn=100)
    translate([bay_d/2-1+D,hoehe,0])
    square([1,1.75]); // 1.7 heigt was still a bit too lose
    }

// slight bump (0.2mm) at both ends    
rotate([0,0,winkel-36.5]) {
    rotate_extrude(angle = 5, $fn=100)
    translate([bay_d/2-1.2+D,hoehe,0])
    square([1.2,1.75]); 
    } 
rotate([0,0,winkel+31.5]) {
    rotate_extrude(angle = 5, $fn=100)
    translate([bay_d/2-1.2+D,hoehe,0])
    square([1.2,1.75]);
    } 
// bump 3mm besides the rail to lock
rotate([0,0,winkel-36.5-5]) {
    rotate_extrude(angle = 1.5, $fn=100)
    translate([bay_d/2-0.8+D,hoehe,0])
    square([0.8,1.75]);  // 0.5 bump height did not "lock" enough.
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

schiene(0,0);
schiene(90,3);
schiene(180,0);
schiene(270,3);