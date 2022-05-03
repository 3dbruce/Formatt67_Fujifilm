//
// Filter Slot for Formatt Hitech 67mm Filter (double height with connector for polarizer)
// Copyright (C) 2021 Uwe Glässner
//

include <../openscad-model-library-master/lib/material.scad>;
include <../openscad-model-library-master/lib/joint/joint_pin.scad>;

// slot lengths (mm)
l = 77; // total length
l1 = 20;  // length until curve 
// slot widths (mm)
w1 = 8;
w2 = 1.0;
w3 = 4.0;
w  = w1+w2+w3;
// slot height (mm)
h1 = 1.5; // curvature thickness
cr = 155; // curvature radius
of = 1.4; // curvature offset for 2mm firecrest filters (instead of 1.4mm Resin) 
h = 4; // total height

D = 0.01; // generic overlap of parts.

module loch(posx,posy){
    union(){
       translate([posx, posy  ,-D]) cylinder(d=3.2, h=2*h+2*D-2, $fn=100);
       translate([posx-5.6/2, posy-4.2-D  ,-D+h-1.0]) cube([5.9,7.5,2.2+2*D]);
    }
}


// thick side of holder with holes and removed corners
difference(){
   translate([-l/2,-w1,0]) cube([l,w1+D,2*h]);
   loch(-l/2+8.5, -8+4.2); 
   loch( l/2-8.5, -8+4.2); 
   // remove corners:
   translate([-l/2-3,-15,-D]) rotate([0,0,45]) cube([10,10,2*h+2*D]);
   translate([l/2+3,-15,-D]) rotate([0,0,45]) cube([10,10,2*h+2*D]);
   // cut magnet holes
   translate([-25,-8-D, 5+D]) cube([10,5.5,2.1]);
   translate([+15,-8-D, 5+D]) cube([10,5.5,2.1]);
   // cut channels to be able to remove magnets
   translate([-21,-4-D, 5+D]) cube([2,5,1.5]);
   translate([+19,-4-D, 5+D]) cube([2,5,1.5]);   
   }
// add holder pins for polarizer
//translate([-l/2+8.5, -8+4.2,2*h]) pin_tack(r=1.2, h=6, lh=2.0, lt=1, bh=0, br=0);
//translate([ l/2-8.5, -8+4.2,2*h]) pin_tack(r=1.2, h=6, lh=2.0, lt=1, bh=0, br=0);
   
// Arc on thin side
intersection(){
    translate([-l/2,0,0]) cube([l,w2+w3,h]);
    difference(){
       translate([0,w3+w2,cr+of]) rotate ([90,90,0]) cylinder(r=cr,h=w3+w2, $fn=1000);
       translate([0,w3+w2+D,cr+of]) rotate ([90,90,0]) cylinder(r=cr-h1+2*D,h=w3+w2+2*D, $fn=1000);
       // leave some pillars under the arc to assist printing, which must be cut afterwards
       // for (i=[0:5]) translate([-l/2+l1+i*6.5-0.6,0,-D+of/2]) cube([6.0,w2,h]);
       for (i=[0:3]) translate([-l/2+l1+i*12.7-0.6,0,-D+of/2]) cube([12.2,w2,h]);
    }
}  

// 2nd Arc on top on thin side
translate([0,0,h]) intersection(){
    translate([-l/2,0,0]) cube([l,w2+w3,h]);
    difference(){
       translate([0,w3+w2,cr+of]) rotate ([90,90,0]) cylinder(r=cr,h=w3+w2, $fn=1000);
       translate([0,w3+w2+D,cr+of]) rotate ([90,90,0]) cylinder(r=cr-h1+2*D,h=w3+w2+2*D, $fn=1000);
       // leave some pillars under the arc to assist printing, which must be cut afterwards
       // for (i=[0:5]) translate([-l/2+l1+i*6.5-0.6,0,-D+of/2]) cube([6.0,w2,h]);
       for (i=[0:3]) translate([-l/2+l1+i*12.7-0.6,0,-D+of/2]) cube([12.2,w2,h]);
    }
}
        
// Add thin sides with removed corners
difference(){
   translate([-l/2-D,0,h-h1]) cube([l1+2*D,w2+w3+D,h1]);
   translate([-l/2-1,-1,-D]) rotate([0,0,45]) cube([10,10,h+2*D]);   
}
difference(){
   translate([ l/2-l1-D,0,h-h1]) cube([l1+2*D,w2+w3+D,h1]);
   translate([l/2+1,-1,-D]) rotate([0,0,45]) cube([10,10,h+2*D]);
}
difference(){
   translate([-l/2-D,0,2*h-h1]) cube([l1+2*D,w2+w3+D,h1]);
   translate([-l/2-1,-1,h-D]) rotate([0,0,45]) cube([10,10,h+2*D]);   
}
difference(){
   translate([ l/2-l1-D,0,2*h-h1]) cube([l1+2*D,w2+w3+D,h1]);
   translate([l/2+1,-1,h-D]) rotate([0,0,45]) cube([10,10,h+2*D]);
}
