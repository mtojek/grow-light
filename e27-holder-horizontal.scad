$fn = 200;

// Parameters
holderInnerR = 20; 
holderWallWidth = 13;
holderHeight = 14;

clipMountWidth = 100;
clipMountDepth = 16;
clipMountHeight = 14;

screwHoleR = 5.4 / 2;
screwHoleLength = 10;

nutWidth = 3;
nutDepth = 8;
nutHeight = 12;
nutOffsetX = -8;

// Calculated
holderOuterR = holderInnerR + holderWallWidth;

// Design

module body() {
    difference() {
        union() {
            e27_mount();
            clip_mount();
        }
        union() {
            e27_mount_cut();
            clip_mount_cut();
            
            rotate([0, 0, 180])
            clip_mount_cut();
        }
    }
}

module e27_mount() {
    cylinder(r = holderOuterR, h = holderHeight);
}

module e27_mount_cut() {
    translate([0,0,-1])
    cylinder(r = holderInnerR, h = holderHeight + 2);
}

module clip_mount() {
    translate([-clipMountWidth/2, -clipMountDepth/2, 0])
    cube([clipMountWidth, clipMountDepth, clipMountHeight]);
}

module clip_mount_cut() {
    translate([clipMountWidth/2 - screwHoleLength + 0.1, 0, clipMountHeight/2])
    rotate([0, 90, 0])
    cylinder(r = screwHoleR, h = screwHoleLength);
    
    translate([clipMountWidth/2 + nutOffsetX, -nutDepth/2, clipMountHeight - nutHeight + 1])
    cube([nutWidth, nutDepth, nutHeight]);
}

body();