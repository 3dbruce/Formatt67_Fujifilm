//
// 67 mm holder for Fujifilm lenses
// Copyright (C) 2021 Uwe Glässner
//
// size of filter plate
plate_w = 85;
plate_d = 80;
plate_h = 6;
// reference diameters of rotating inlay to fit to the filter plate
rim_r2 = 81.5 / 2; 
rim_r1 = 76.5 / 2;

D = 0.01; // generic overlap of parts.

module loch(posx, posy, height){
  union(){
     translate([posx, posy,-D]) cylinder(d=3, h=height+2*D, $fn=100);
     translate([posx, posy,-D]) cylinder(h = 1.5, r1 = 3, r2 = 1.5, $fn=100);
  }
}
module plate(width, depth, height, rad1, rad2) {

    difference(){
      translate([-width/2,-depth/2, D]) cube([width,depth,height/2]); // plate
      inlay(rad1, rad2, height+D); // remove inlay
      // screw holes
      loch(-width/2+4.5, depth/2-10, height);
      loch(-width/2+4.5,-depth/2+10, height); 
      loch(+width/2-4.5, depth/2-10, height); 
      loch(+width/2-4.5,-depth/2+10, height);  
      };

  };
module inlay(rad1, rad2, height){
   // build general core of turning bayonett inlay w/o decorations
    union(){
       // rim
       translate([0,0,0]) cylinder(r1=rad1, r2=rad2, h=height/2-0.5, $fn=100);
       translate([0,0,height/2-0.5-D]) cylinder(r=rad2, h=1, $fn=100);
       translate([0,0,height/2+0.5-2*D]) cylinder(r1=rad2, r2=rad1, h=height/2-0.5, $fn=100);
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
 diam = 63.8; // bayonett diameter (mm)
    
 difference(){
    inlay(rad1, rad2, height); // start with generic inlay
    // carve out riffelung:
    for (i=[0:60])
       rotate([0, 0, 360 / 60 * i]) translate([0,rad2, 0 ])
       cylinder(d=3, h=height+2*D, $fn=100);
    // carveout inner cylinder with the bayjonett diameter:
    translate([0,0,-D]) cylinder(d=diam, h=height+2*D, $fn=100);
    // cut hole behind soft end-locks to allow a bit of flexibility
    rail(diam, -5,20,1,height+2*D,1,1.7);
    rail(diam,175,20,1,height+2*D,1,1.7);
};
// build bajonett rails
rail(diam,  0, 12,  0,3.6,0.4); // soft endlock of rail
rail(diam, 12,360,  0,0.6,1.2); // lower rail with full circle
rail(diam, 90, 12,  0,3.6,1.2); // hard startpoint of rail
rail(diam,102, 78,2.2,1.4,1.2); // upper rail 1
rail(diam,180, 12,  0,3.6,0.4); //  soft endlock of rail
rail(diam,270, 12,  0,3.6,1.2); // hard startpoint of rail
rail(diam,282, 78,2.2,1.4,1.2); // upper rail 2

};
module bajonett_samy12(rad1, rad2, height){
 
 // bajonett size for Samyang 12/2.0
 diam = 73.5; // bayonett diameter (mm)
 
 difference(){
    inlay(rad1, rad2, height); // start with generic inlay
    // carve out riffelung:
    for (i=[0:60])
       rotate([0, 0, 360 / 60 * i]) translate([0,rad2, 0 ])
       cylinder(d=3, h=height+2*D, $fn=100);
    // carveout inner cylinder with the bayjonett diameter:
    translate([0,0,-D]) cylinder(d=diam, h=height+2*D, $fn=100);

  };
  // build bajonett rails:
  rail (diam,     0,  5, 0, 1.75, 1.2); // 0.2mm bump at the beginning
  rail (diam,     0, 73, 0, 1.75, 1.0); // main rail
  rail (diam,   +68,  5, 0, 1.75, 1.2); // 0.2mm bump at the end
  rail (diam,    -5,1.5, 0, 1.75, 0.8); // bump 3mm besides the rail to lock

  rail (diam, 90   ,  5, 3, 1.75, 1.2); // 0.2mm bump at the beginning
  rail (diam, 90   , 73, 3, 1.75, 1.0); // main rail
  rail (diam, 90+68,  5, 3, 1.75, 1.2); // 0.2mm bump at the end
  rail (diam, 90 -5,1.5, 3, 1.75, 0.8); // bump 3mm besides the rail to lock

  rail (diam,180   ,  5, 0, 1.75, 1.2); // 0.2mm bump at the beginning
  rail (diam,180   , 73, 0, 1.75, 1.0); // main rail
  rail (diam,180+68,  5, 0, 1.75, 1.2); // 0.2mm bump at the end
  rail (diam,180 -5,1.5, 0, 1.75, 0.8); // bump 3mm besides the rail to lock

  rail (diam,270   ,  5, 3, 1.75, 1.2); // 0.2mm bump at the beginning
  rail (diam,270   , 73, 3, 1.75, 1.0); // main rail
  rail (diam,270+68,  5, 3, 1.75, 1.2); // 0.2mm bump at the end
  rail (diam,270 -5,1.5, 3, 1.75, 0.8); // bump 3mm besides the rail to lock
}


// main
bajonett_xf1855(rim_r1, rim_r2, plate_h); // bajonett inlay
// bajonett_samy12(rim_r1, rim_r2, plate_h); // bajonett inlay
color([0.7,0.8,0]) plate (plate_w, plate_d, plate_h, rim_r1, rim_r2); // lower plate
// translate ([0, 0, plate_h]) rotate ([0, 180, 0]) // add upper plate
   // color([0.7,0.8,0]) plate(plate_w, plate_d, plate_h, rim_r1, rim_r2);

