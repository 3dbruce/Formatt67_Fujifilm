//
// 67 mm holder for Samyang 12/2.0 lens
// Copyright (C) 2021 Uwe Glässner
//

// bayonett diameter (mm)
bay_d = 73.5;    

// bayonett wall thickness (mm)
bay_w = 2;
// bayonett rim size (mm)
bay_r = 2;
// rim thickness
bay_t = 1;
// height of bayonett (mm)
bay_h = 5;     

// filter plate
plate_w = 85;
plate_d = 80;
plate_h = 5;

D = 0.01; // generic overlap of parts.

module schiene(winkel,hoehe){

rotate([0,0,winkel-36.5]) {
    rotate_extrude(angle = 73, $fn=100)
    translate([bay_d/2-1,hoehe,0])
    square([1.1,1.8]);
    }
    
rotate([0,0,winkel-36.5]) {
    rotate_extrude(angle = 5, $fn=100)
    translate([bay_d/2-1.2,hoehe,0])
    square([1.1,1.8]);
    } 
    
rotate([0,0,winkel+31.5]) {
    rotate_extrude(angle = 5, $fn=100)
    translate([bay_d/2-1.2,hoehe,0])
    square([1.1,1.8]);
    } 
}

 difference(){
    // rim
    union(){
       translate([0,0,              0]) cylinder(r=bay_d/2+bay_w,       h=(bay_h-bay_t)/2, $fn=100);
       translate([0,0,(bay_h-bay_t)/2]) cylinder(r=bay_d/2+bay_w+bay_r, h=bay_t, $fn=100);
       translate([0,0,(bay_h+bay_t)/2]) cylinder(r=bay_d/2+bay_w,       h=(bay_h-bay_t)/2, $fn=100);
    }
    // riffelung
    for (i=[0:60])
       rotate([0, 0, 360 / 60 * i]) translate([0,bay_d/2+bay_w+bay_r, (bay_h-bay_t)/2-D ])
       cylinder(d=2.5, h=bay_t+2*D, $fn=100);
    // inner cylinder
    translate([0,0,-D]) cylinder(d=bay_d, h=bay_h+2*D, $fn=100);
    
};

schiene(0,0);
schiene(90,3);
schiene(180,0);
schiene(270,3);