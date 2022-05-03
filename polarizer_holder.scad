//
// 67 mm filter holder for Fujifilm lenses
// Copyright (C) 2021 Uwe Glässner
//
// size of filter plate
plate_w = 85;
plate_d = 80;
plate_h = 5;
// reference diameters of rotating inlay to fit to the filter plate
rim_r2 = 78.5 / 2; // full radius
rim_r1 = 76.5 / 2; // rim radius

D = 0.01; // generic overlap of parts.

use <threads-scad/threads.scad>

module loch(posx, posy, height){
  union(){
     translate([posx, posy,-D]) cylinder(d=3, h=height+2*D, $fn=100);
     translate([posx, posy,-D]) cylinder(h = 1.7, r1 = 3, r2 = 1.5, $fn=100);
  }
}
module plate(width, depth, height, rad1, rad2) {

    difference(){
      translate([-width/2,-depth/2, D]) cube([width,depth,height]); // plate
      // cut magnet holes
      translate([-width/2-D,-25+D, 1.2+D]) cube([5.5,10,2.1]);
      translate([-width/2-D,+15+D, 1.2+D]) cube([5.5,10,2.1]);
      translate([+width/2-5.5+D,-25+D, 1.2+D]) cube([5.5,10,2.1]);
      translate([+width/2-5.5+D,+15+D, 1.2+D]) cube([5.5,10,2.1]);
      // cut channels to be able to remove magnets
      translate([-width/2-D+5.5,-21+D, 1.2+D]) cube([10,2,1.5]);
      translate([-width/2-D+5.5,+19-D, 1.2+D]) cube([10,2,1.5]);
      translate([+width/2-D-10.5,-21+D, 1.2+D]) cube([10,2,1.5]);
      translate([+width/2-D-10.5,+19-D, 1.2+D]) cube([10,2,1.5]);  
      // screw holes
      //loch(-width/2+4.5, depth/2-10, height);
      //loch(-width/2+4.5,-depth/2+10, height); 
      //loch(+width/2-4.5, depth/2-10, height); 
      //loch(+width/2-4.5,-depth/2+10, height);  
      };
  };

 // lower plate
ScrewHole(outer_diam=76.5, height=10, pitch=0.75, tooth_angle=30, tolerance=0.4, tooth_height=0)
translate ([0, 0, +D]) color([0.7,0.8,0]) plate (plate_w, plate_d, plate_h, rim_r1, rim_r2);
