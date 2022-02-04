//
// 67 mm holder for Fujifilm XF 18-55 lens
// Copyright (C) 2021 Uwe Glässner
//

// bayonett diameter (mm)
//bay_d = 73.5;
bay_d = 63.8; 

// bayonett wall thickness (mm)
//bay_w = 3;
bay_w = 12.7;

// bayonett rim size (mm)
//bay_r = 5;
bay_r = 5;

// height of bayonett (mm)
bay_h = 6;     

rim_r1 = (bay_d + bay_w)/2;
rim_r2 = (bay_d + bay_w + bay_r)/2;
// rim_r2 = 81,5/2

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
    // carve out riffelung
    for (i=[0:60])
       rotate([0, 0, 360 / 60 * i]) translate([0,rim_r2, 0 ])
       cylinder(d=3, h=plate_h+2*D, $fn=100);
    // carveout inner cylinder
    translate([0,0,-D]) cylinder(d=bay_d, h=bay_h+2*D, $fn=100);
    
    // cut hole behind soft end-locks to allow sufficient flexibility
    rail( -5,20,1,bay_h+2*D,1,1.7);
    rail(175,20,1,bay_h+2*D,1,1.7);
};


// set bajonett rails
rail(  0, 12,0,3.6,0.4); // soft endlock of rail
// rail( 12,78,0,1.4,1.2); // lower rail 1
rail( 12,360,0,0.6,1.2); // lower rail 1
rail( 90, 12,0,3.6,1.2); // hard startpoint of rail
rail(102, 78,2.2,1.4,1.2); // upper rail 1
rail(180, 12,0,3.6,0.4); //  soft endlock of rail
// rail(192,78,0,1.4,1.2); // lower rail 2
rail(270, 12,0,3.6,1.2); // hard startpoint of rail
rail(282, 78,2.2,1.4,1.2); // upper rail 2
