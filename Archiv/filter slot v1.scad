//
// Filter Slot for Formatt Hitech 67mm Filter
// Copyright (C) 2021 Uwe Glässner
//

// slot lengths (mm)
l = 77; // total length
l1 = 20;  // length until curve 
// slot widths (mm)
w1 = 8;
w2 = 1.8;
w3 = 4.2;
w  = w1+w2+w3;
// slot height (mm)
h1 = 1.5; // curvature thickness
cr = 80; // curvature radius
of = 0.6; // curvature offset for 2mm firecrest filters (instead of 1.4mm Resin) 
h = 4; // total height

D = 0.01; // generic overlap of parts.

module loch(posx,posy){
    union(){
       translate([posx, posy,-D]) cylinder(d=3, h=h+2*D, $fn=100);
    }
}

intersection(){
    translate([-l/2,-w1,0]) cube([l,w,h]);
    difference(){
       translate([0,w3+w2,cr+of]) rotate ([90,90,0]) cylinder(r=cr,h=w3, $fn=100);
       translate([-D,w3+w2+D,cr+of-D]) rotate ([90,90,0]) cylinder(r=cr-h1+2*D,h=w3+2*D, $fn=100);
    }
}

 difference(){
    // slot
    translate([-l/2,-w1,0]) cube([l,w,h]);
    // carve out middle slot 
    translate([-l/2+l1+D,0,-D]) cube([l-2*l1,w2,h+2*D]);
    // carve out sides
    translate([-l/2-D,0,-D]) cube([l+2*D,w2+w3+D,h-h1+2*D]);
    // carve out curvature
    translate([-D,w3+w2+D,cr+of-D]) rotate ([90,90,0]) cylinder(r=cr-h1+2*D,h=w3+2*D, $fn=100);
     
    // screw holes
    loch(-l/2+8.5, -8+3.7); 
    loch( l/2-8.5, -8+3.7); 
     
    // remove corners 
    translate([-l/2,-1,-D]) rotate([0,0,45]) cube([10,10,h+2*D]);
    translate([-l/2,-15,-D]) rotate([0,0,45]) cube([10,10,h+2*D]);
    translate([l/2,-1,-D]) rotate([0,0,45]) cube([10,10,h+2*D]);
    translate([l/2,-15,-D]) rotate([0,0,45]) cube([10,10,h+2*D]);
}
