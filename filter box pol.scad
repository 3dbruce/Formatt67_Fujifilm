// MODIFY BELOW VARIABLES TO CUSTOMISE
wallthickness=1.2; // this is the wall of the lip, the box is twice as thick

internalx=82; // internal x dimension

internaly=29.4; // internal y dimension

internalz=85; // internal overall z dimension 75

internal_lidz=20; // this is taken of off the internalz for the bottom height and acts as the lid internal height

lip_overlap = internal_lidz/2.5; // how much overlap between box and lid, this works as a default but can be shrunk as needed

lipspacing=0; // this amount is take off of the wall thickness on the lip to increase spacing, if your lid is too tight you can increase this but it will reduce the actual wall thickness on the lip so too much and you will have to increase the wallthickness to compensate. Should be 0 in ideal world, you will likely be better just lightly sanding the lip unless your printer is way out

//#############################
// INTERNAL VARIABLES, DO NOT MODIFY
internal_botz=internalz-internal_lidz;

actual_y=internaly+(4*wallthickness);
actual_x=internalx+(4*wallthickness);
actual_lidz=internal_lidz+(2*wallthickness);
actual_botz=internal_botz+(2*wallthickness);

lip_x = internalx+(2*wallthickness);
lip_y = internaly+(2*wallthickness);


//###########################

module bottom() {
    difference() {
        union() {
            // outer cube
            scale([actual_x,actual_y,actual_botz])cube(1);
            // inner cube incl. lid
            translate([wallthickness,wallthickness,actual_botz])scale([lip_x,lip_y,lip_overlap])cube(1);
        }
        // remove inner volume
        translate([(2*wallthickness),(2*wallthickness),(2*wallthickness)])scale([internalx,internaly,internalz])cube(1);
    }
    // add outer boxes for filters:
    translate([2*wallthickness,2*wallthickness])scale([6.5,21.4,actual_botz+lip_overlap])cube(1);
    translate([actual_x-2*wallthickness-6.5,2*wallthickness])scale([6.5,21.4,actual_botz+lip_overlap])cube(1);
    // add text on top:
    translate([1*wallthickness+0.2,2*wallthickness+5.5,actual_botz+lip_overlap]) {linear_extrude(height=1) {
    text("GND", size=2.2, font="Arial Black", halign="left", valign="center");}}
    translate([1*wallthickness+0.2,2*wallthickness+2.2,actual_botz+lip_overlap]) {linear_extrude(height=1) {
    text("GND", size=2.2,, font="Arial Black", halign="left", valign="center");}}
    translate([1*wallthickness+0.5,2*wallthickness+8.8,actual_botz+lip_overlap]) {linear_extrude(height=1) {
    text("REV", size=2.2, font="Arial Black", halign="left", valign="center");}}
    translate([1*wallthickness+1.2,2*wallthickness+12.2,actual_botz+lip_overlap]) {linear_extrude(height=1) {
    text("ND", size=2.2, font="Arial Black", halign="left", valign="center");}}
    translate([1*wallthickness+1.2,2*wallthickness+15.6,actual_botz+lip_overlap]) {linear_extrude(height=1) {
    text("ND", size=2.2, font="Arial Black", halign="left", valign="center");}}
    translate([1*wallthickness+1.2,2*wallthickness+19,actual_botz+lip_overlap]) {linear_extrude(height=1) {
    text("ND", size=2.2, font="Arial Black", halign="left", valign="center");}}
    translate([actual_x-2*wallthickness+1.0,2*wallthickness+8.8,actual_botz+lip_overlap]) {linear_extrude(height=1) {
    text("GND", size=2.2, font="Arial Black", halign="right", valign="center");}}
    translate([actual_x-2*wallthickness,2*wallthickness+2.2,actual_botz+lip_overlap]) {linear_extrude(height=1) {
    text("0.9", size=2.2, font="Arial Black", halign="right", valign="center");}}
    translate([actual_x-2*wallthickness,2*wallthickness+5.5,actual_botz+lip_overlap]) {linear_extrude(height=1) {
    text("1.5", size=2.2, font="Arial Black", halign="right", valign="center");}}
    translate([actual_x-2*wallthickness,2*wallthickness+12.2,actual_botz+lip_overlap]) {linear_extrude(height=1) {
    text("1.8", size=2.2, font="Arial Black", halign="right", valign="center");}}
    translate([actual_x-2*wallthickness,2*wallthickness+15.6,actual_botz+lip_overlap]) {linear_extrude(height=1) {
    text("3.0", size=2.2, font="Arial Black", halign="right", valign="center");}}
    translate([actual_x-2*wallthickness,2*wallthickness+19.0,actual_botz+lip_overlap]) {linear_extrude(height=1) {
    text("4.8", size=2.2, font="Arial Black", halign="right", valign="center");}}
    // add gliders for filters
    for (i=[0:6]) translate([2*wallthickness+6.5,2*wallthickness+3.4*i,0])scale([3,1,actual_botz+lip_overlap])cube(1);
    for (i=[0:6]) translate([actual_x-2*wallthickness-9.5,2*wallthickness+3.4*i,0])scale([3,1,actual_botz+lip_overlap])cube(1);
    // make gliders slioghtly thicker at the bottom 10mm to "lock" the filters securely
    for (i=[0:6]) translate([2*wallthickness+6.5,2*wallthickness+3.4*i-0.17,0])scale([3,1.34,10])cube(1);
    for (i=[0:6]) translate([actual_x-2*wallthickness-9.5,2*wallthickness+3.4*i-0.17,0])scale([3,1.34,10])cube(1);    
}


module lid() {
    difference() {
        scale([actual_x,actual_y,actual_lidz+lip_overlap])cube(1);
        
        translate([(2*wallthickness),(2*wallthickness),-.1])scale([internalx,internaly,internal_lidz+lip_overlap+.1])cube(1);
        
        translate([(wallthickness)-lipspacing/2,(wallthickness)-lipspacing/2,-.1])scale([lip_x+lipspacing,lip_y+lipspacing,lip_overlap+.3])cube(1);
    }
}

//translate([0,0,actual_botz + lip_overlap + 10])lid();


bottom();
//lid();





