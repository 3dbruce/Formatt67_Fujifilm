//
// 67 mm filter dust cap for filter holder
// Copyright (C) 2021 Uwe Glässner
//
// size of filter plate
plate_w = 80;
plate_d = 67;
plate_h = 1.4;

D = 0.01; // generic overlap of parts.





translate([-plate_w/2,-plate_d/2, D]) cube([plate_w,plate_d, plate_h]); // plate
translate([-plate_d/2+4, -15, D+plate_h]) cube([2, 30, 4]); // griff 1
translate([+plate_d/2-6,-15, D+plate_h]) cube([2, 30, 4]); // griff 2
translate([-plate_w/2,-plate_d/2, D+plate_h]) cube([plate_w, 5, 0.7]); // schiene 1
translate([-plate_w/2,+plate_d/2-5, D+plate_h]) cube([plate_w, 5, 0.7]); // schiene 2

translate([0, 5, plate_h]) {linear_extrude(height=1) {
    text("Fujifilm", size=10, font="Arial Black", halign="center", valign="center");}} 
translate([0, -8, plate_h]) {linear_extrude(height=1) {
    text("18-55", size=12, font="Arial Black", halign="center", valign="center");}}  