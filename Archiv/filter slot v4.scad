//
// Filter Slot for Formatt Hitech 67mm Filter
// Copyright (C) 2021 Uwe Glässner
//

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
cr = 180; // curvature radius
of = 1.5; // curvature offset for 2mm firecrest filters (instead of 1.4mm Resin) 
h = 4; // total height

D = 0.01; // generic overlap of parts.

module loch(posx,posy){
    union(){
       translate([posx, posy,-D]) cylinder(d=3.1, h=h+2*D, $fn=100);
       translate([posx, posy,-D+(h-2.0)]) cylinder(d=10.4, h=h+2*D, $fn=6);
    }
}


// thick side of holder with holes and removed corners
difference(){
   translate([-l/2,-w1,0]) cube([l,w1+D,h]);
   loch(-l/2+8.5, -8+3.7); 
   loch( l/2-8.5, -8+3.7); 

   translate([-l/2,-15,-D]) rotate([0,0,45]) cube([10,10,h+2*D]);

   translate([l/2,-15,-D]) rotate([0,0,45]) cube([10,10,h+2*D]);
   }

// Arc on thin side
intersection(){
    translate([-l/2,0,0]) cube([l,w2+w3,h]);
    difference(){
       translate([0,w3+w2,cr+of]) rotate ([90,90,0]) cylinder(r=cr,h=w3+w2, $fn=100);
       translate([0,w3+w2+D,cr+of]) rotate ([90,90,0]) cylinder(r=cr-h1+2*D,h=w3+w2+2*D, $fn=100);
       // remove pillars under bridge
       for (i=[0:5]) translate([-l/2+l1+i*6.5-0.6,0,-D+of/2]) cube([6.0,w2,h]);
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





 
