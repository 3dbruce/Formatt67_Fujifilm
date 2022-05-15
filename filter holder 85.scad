//
// 67 mm filter holder for Fujifilm lenses
// Copyright (C) 2021-2022 Uwe Glässner
//
// size of filter plate
plate_w = 102;
plate_d = 85;
plate_h = 6; // Thickness of filter holder (plate_h/2 per plate)
polar_h = 4; // Thickness of polarizer
// reference diameters of rotating inlay to fit to the filter plate
rim_r2 = 86 / 2; // full radius
rim_r1 = 84 / 2; // rim radius

D = 0.01; // generic overlap of parts.

use <threads-scad/threads.scad>

module loch(posx, posy, height){
  union(){
    translate([posx, posy,-D]) cylinder(d=3, h=height+2*D, $fn=100);
    translate([posx, posy,-D]) cylinder(h = 1.7, r1 = 3, r2 = 1.5, $fn=100);
  }
};
module lochslot(posx,posy,h){
    union(){
       translate([posx, posy  ,-D]) cylinder(d=3.2, h=2*h+2*D-2, $fn=100);
       translate([posx-5.6/2, posy-4.2-D  ,-D+h-1.0]) cube([5.9,7.5,2.2+2*D]);
    }
}
module plate(width, depth, height, rad1, rad2) {
    difference(){
      // start with cube for plate:
      union(){
        translate([-width/2,-depth/2, D]) cube([width,depth,height/2]);
        translate([0, 0, D ]) cylinder(d=93, h=height/2+2*D, $fn=300);
      }
      // remove corners:
      translate([-width/2,-depth/2,-D]) rotate([0,0,45]) translate([-3,-3,0]) cube([6,6,height+D]);
      translate([-width/2, depth/2,-D]) rotate([0,0,45]) translate([-3,-3,0]) cube([6,6,height+D]);
      translate([ width/2, depth/2,-D]) rotate([0,0,45]) translate([-3,-3,0]) cube([6,6,height+D]);
      translate([ width/2,-depth/2,-D]) rotate([0,0,45]) translate([-3,-3,0]) cube([6,6,height+D]);
      // remove inlay:
      inlay(rad1, rad2, height+D);
      // drill screw holes:
      loch(-width/2+4.5, depth/2-10, height);
      loch(-width/2+4.5,-depth/2+10, height); 
      loch(+width/2-4.5, depth/2-10, height); 
      loch(+width/2-4.5,-depth/2+10, height);  
      // remove sections to allow button presses:
      translate([-width/2+2,-15, 1.5]) cube([width-4,30,height/2]);
      // Attention: Before you print this, remove comment before buttons:
      buttons(width,0); // remove button shape with full size
    };

};
module inlay(rad1, rad2, height){
   // build general core of turning bayonett inlay w/o decorations
    union(){
       // rim
       translate([0,0,0]) cylinder(r1=rad1, r2=rad2, h=height/2-0.5+D, $fn=100);
       translate([0,0,height/2-0.5-D]) cylinder(r=rad2, h=1+D, $fn=100);
       translate([0,0,height/2+0.5-2*D]) cylinder(r1=rad2, r2=rad1, h=height/2-0.5+D, $fn=100);
       };
}
module rail(diam, startwinkel, winkel, offset, height, thickness, roffset=0){
  // module to build bajonett rails
  // diam = diameter of the bajonett
  // startwinkel = starting angle of rail
  // winkel = angle how far the rail extends
  // offset = offset of the rail from the bottom bayonett
  // height = height of rail
  // thickness = thickness of rail
  // roffset Set in case the rail is not at bayonett surface e.g. to carve out
    
  rotate([0,0,startwinkel]) {
     rotate_extrude(angle = winkel, $fn=100)
     translate([diam/2-thickness+roffset+D,offset,-D])
     square([thickness,height]);
     }
}
module bajonett_xf1855(rad1, rad2, height){
    
 // bajonett size for Fujifilm XF 18-55
 diam = 64.0; // bayonett diameter (mm)
    
 difference(){
    inlay(rad1, rad2, height); // start with generic inlay
    // carve out riffelung:
    for (i=[0:180])
       rotate([0, 0, 360 / 180 * i]) translate([0,rad2, 0 ])
       cylinder(d=1, h=height+2*D, $fn=10);
    // carveout inner cylinder with the bayjonett diameter:
    translate([0,0,-D]) cylinder(d=diam, h=height+2*D, $fn=100);
    // cut hole behind soft end-locks to allow a bit of flexibility
    rail(diam, -5,20,0-D,height+2*D,1,1.7);
    rail(diam,175,20,0-D,height+2*D,1,1.7);
    };
  // build bajonett rails
  rail(diam, -1, 12,  0,3.4,0.5); // soft endlock of rail
  rail(diam, 15, 70,  0,0.6,1.2); // lower rail 1
  rail(diam, 90, 10,  0,3.4,1.2); // hard startpoint of rail
  rail(diam,105, 70,2.2,1.2,1.2); // upper rail 1
  rail(diam,179, 12,  0,3.4,0.5); // soft endlock of rail
  rail(diam,195, 70,  0,0.6,1.2); // lower rail 2
  rail(diam,270, 10,  0,3.4,1.2); // hard startpoint of rail
  rail(diam,285, 70,2.2,1.2,1.2); // upper rail 2

};
module bajonett_xf16(rad1, rad2, height){
    
 // bajonett size for Fujifilm XF 16/2.8
 diam = 55.9; // bayonett diameter (mm)
    
 difference(){
    inlay(rad1, rad2, height); // start with generic inlay
    // carve out riffelung:
    for (i=[0:180])
       rotate([0, 0, 360 / 180 * i]) translate([0,rad2, 0 ])
       cylinder(d=1, h=height+2*D, $fn=10);
    // carveout inner cylinder with the bayjonett diameter:
    translate([0,0,-D]) cylinder(d=diam, h=height+2*D, $fn=100);
    // cut hole behind soft end-locks to allow a bit of flexibility
    rail(diam, -5,30,0-D,height+2*D,1,1.7);
    rail(diam,175,30,0-D,height+2*D,1,1.7);
    // remove 56mm cylinder to fit bayonett
    translate([0,0,3.4-D]) cylinder(r=57.4/2, h=5+D, $fn=100);
    
    };
  // build bajonett rails
  rail(diam,  0, 20,  0,3.4,0.5); // soft endlock of rail
  rail(diam, 25, 60,  0,0.6,1.2); // lower rail 1
  rail(diam, 90, 20,  0,3.4,1.2); // hard startpoint of rail
  rail(diam,115, 60,2.2,1.2,1.2); // upper rail 1
  rail(diam,180, 20,  0,3.4,0.5); // soft endlock of rail
  rail(diam,205, 60,  0,0.6,1.2); // lower rail 2
  rail(diam,270, 20,  0,3.4,1.2); // hard startpoint of rail
  rail(diam,295, 60,2.2,1.2,1.2); // upper rail 2

};
module bajonett_samy12(rad1, rad2, height){
 
 // bajonett size for Samyang 12/2.0
 diam = 73.5; // bayonett diameter (mm)
 
 difference(){
    inlay(rad1, rad2, height); // start with generic inlay
    // carve out riffelung:
    for (i=[0:180])
       rotate([0, 0, 360 /180 * i]) translate([0,rad2, 0 ])
       cylinder(d=1, h=height+2*D, $fn=10);
    // carveout inner cylinder with the bayjonett diameter:
    translate([0,0,-D]) cylinder(d=diam, h=height+2*D, $fn=100);

  };
  // build bajonett rails:
  rail (diam,     0,  5,1.4, 1.60, 1.0); // 0.1mm bump at the beginning
  rail (diam,     0, 73,1.4, 1.60, 0.8); // main rail
  rail (diam,   +68,  5,1.4, 1.60, 1.0); // 0.1mm bump at the end
  rail (diam,   -5.5,1.0,1.4, 1.60, 0.6); // bump 3mm besides the rail to lock
  rail (diam,   -6.5,1.0,1.4, 1.60, 0.4); // bump 3mm besides the rail to lock
  rail (diam,   -7.5,1.0,1.4, 1.60, 0.2); // bump 3mm besides the rail to lock

  rail (diam, 90   ,  5,4.4, 1.60, 1.0); // 0.1mm bump at the beginning
  rail (diam, 90   , 73,4.4, 1.60, 0.8); // main rail
  rail (diam, 90+68,  5,4.4, 1.60, 1.0); // 0.1mm bump at the end

  rail (diam,180   ,  5,1.4, 1.60, 1.0); // 0.1mm bump at the beginning
  rail (diam,180   , 73,1.4, 1.60, 0.8); // main rail
  rail (diam,180+68,  5,1.4, 1.60, 1.0); // 0.1mm bump at the end
  rail (diam,180-5.5,1.0,1.4, 1.60, 0.6); // bump 3mm besides the rail to lock
  rail (diam,180-6.5,1.0,1.4, 1.60, 0.4); // bump 3mm besides the rail to lock
  rail (diam,180-7.5,1.0,1.4, 1.60, 0.2); // bump 3mm besides the rail to lock

  rail (diam,270   ,  5,4.4, 1.60, 1.0); // 0.1mm bump at the beginning
  rail (diam,270   , 73,4.4, 1.60, 0.8); // main rail
  rail (diam,270+68,  5,4.4, 1.60, 1.0); // 0.1mm bump at the end
}
module buttons(width,spce=0.2){
  tot_len = 40; // total length of button holder
  but_len = 10; // length of button 
  // spce = space between button and the holder
  
    translate([-width/2+1.5,-tot_len/2,1.5]) cube([1-spce,tot_len-spce,3-spce]); // button holder
    difference(){
      translate([-width/2-1,-but_len/2,1.5]) cube([10-spce,but_len-spce,3-spce]); // actual button
      translate([-0.5,0,0]) bajonett_xf1855(rim_r1, rim_r2, plate_h); // riffelung
    };
    
    translate([width/2-2.5,-tot_len/2,1.5]) cube([1-spce,tot_len-spce,3-spce]); // button holder
    difference(){
      translate([+width/2-9,-but_len/2,1.5]) cube([10-spce,but_len-spce,3-spce]); // actual button
      translate([+0.5,0,0]) bajonett_xf1855(rim_r1, rim_r2, plate_h); // riffelung
    };
}
module slot(l,l1,w1,w2,w3,of,h){
   // l  = total slot length
   // l1 = length until curve starts
   // w1 = thickness of width-side of slot
   // w2 = distance between thick side and curved rails
   // w3 = thickness of curved rails
   // h = total height per slot (two slots in total)
   // of = curvature offset (use 2.0mm for firecrest and 1.4mm for Resin) 

   w = w1+w2+w3; // total width
   h1 = 1.5; // curvature thickness
   cr = 155; // curvature radius

   // thick side of holder with holes and removed corners
   difference(){
      translate([-l/2,-w1,0]) cube([l,w1+D,2*h]);
      //lochslot(-l/2+8.5, -8+4.2, h); 
      //lochslot( l/2-8.5, -8+4.2, h);
      lochslot(-32.5, -8+4.2, h); 
      lochslot( 32.5, -8+4.2, h); 
      // remove corners:
      translate([-l/2,-w1,-D]) rotate([0,0,45]) translate([-3,-3,0]) cube([6,6,2*h+2*D]);
      translate([ l/2,-w1,-D]) rotate([0,0,45]) translate([-3,-3,0]) cube([6,6,2*h+2*D]);
      // cut magnet holes
      translate([-25,-8-D, 5+D]) cube([10,5.5,2.1]);
      translate([+15,-8-D, 5+D]) cube([10,5.5,2.1]);
      // cut channels to be able to remove magnets
      translate([-21,-4-D, 5+D]) cube([2,5,1.5]);
      translate([+19,-4-D, 5+D]) cube([2,5,1.5]);   
   }
   
   // Arc on thin side
   intersection(){
      translate([-l/2,0,0]) cube([l,w2+w3,h]);
      difference(){
         translate([0,w3+w2,cr+of]) rotate ([90,90,0]) cylinder(r=cr,h=w3+w2, $fn=1000);
         translate([0,w3+w2+D,cr+of]) rotate ([90,90,0]) cylinder(r=cr-h1+2*D,h=w3+w2+2*D, $fn=1000);
         // leave some pillars under the arc to assist printing, which must be cut afterwards
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
}
module polarizer(width, depth, height, rad1, rad2) {
  ScrewHole(outer_diam=94.2, height=10, pitch=0.75, tooth_angle=30, tolerance=0.4, tooth_height=0)
  difference(){
    union(){
      translate([-width/2,-depth/2, D]) cube([width,depth,height]);
      translate([0, 0, D ]) cylinder(d=104, h=height+2*D, $fn=300);
    }
    // remove cylinder to be able to screw filter further in
    translate([0,0,2]) cylinder(d=98.3, h=3.0+2*D, $fn=1300);
    // remove corners:
    translate([-width/2,-depth/2,0]) rotate([0,0,45]) translate([-3,-3,0]) cube([6,6,height+2*D]);
    translate([-width/2, depth/2,0]) rotate([0,0,45]) translate([-3,-3,0]) cube([6,6,height+2*D]);
    translate([ width/2, depth/2,0]) rotate([0,0,45]) translate([-3,-3,0]) cube([6,6,height+2*D]);
    translate([ width/2,-depth/2,0]) rotate([0,0,45]) translate([-3,-3,0]) cube([6,6,height+2*D]);
    // cut magnet holes
    translate([-width/2-D,-25+D, 0.9+D]) cube([5.2,10,2.1]);
    translate([-width/2-D,+15+D, 0.9+D]) cube([5.2,10,2.1]);
    translate([+width/2-5.0+D,-25+D, 0.9+D]) cube([5.0,10,2.1]);
    translate([+width/2-5.0+D,+15+D, 0.9+D]) cube([5.0,10,2.1]);
    // cut channels to be able to remove magnets
    translate([-width/2-D+5.0,-21+D, 0.9+D]) cube([10,2,1.5]);
    translate([-width/2-D+5.0,+19-D, 0.9+D]) cube([10,2,1.5]);
    translate([+width/2-D-10.5,-21+D, 0.9+D]) cube([10,2,1.5]);
    translate([+width/2-D-10.5,+19-D, 0.9+D]) cube([10,2,1.5]);  
    };
};
// main
//buttons(plate_w);
//bajonett_xf1855(rim_r1, rim_r2, plate_h); // bajonett inlay
//bajonett_xf16(rim_r1, rim_r2, plate_h); // bajonett inlay
//bajonett_samy12(rim_r1, rim_r2, plate_h); // bajonett inlay

 // lower plate:
//translate ([0, 0, +D]) color([0.7,0.8,0]) plate (plate_w, plate_d, plate_h, rim_r1, rim_r2);
// add upper plate:
//translate ([0, 0, plate_h+D]) rotate ([0, 180, 0]) color([0.7,0.8,0]) plate(plate_w, plate_d, plate_h, rim_r1, rim_r2);
// add slot holders:
//translate ([plate_w/2-8, 0, plate_h+D]) rotate ([0, 0, 90]) slot(l=plate_d, l1=20, w1=8, w2=1, w3=4, of=1.4, h=4);
//translate ([-plate_w/2+8, 0, plate_h+D]) rotate ([0, 0, 270]) slot(l=plate_d, l1=20, w1=8, w2=1, w3=4, of=1.4, h=4);
//translate ([0,0,8]) rotate ([90, 0, 0]) slot(l=plate_d, l1=22, w1=8, w2=1, w3=4, of=1.4, h=4);
// add polarizer:
translate ([0, 0, 14+D]) color([0.7,0.8,1]) polarizer (plate_w, plate_d, polar_h, rim_r1, rim_r2);