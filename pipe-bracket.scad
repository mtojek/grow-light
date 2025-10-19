$fn = 200;

// Parameters
bracketWidth = 90;
bracketInnerR = 24;
bracketWallWidth = 5;
bracketHeight = 14;

armLength = 50;
armHeight = 5;
screwHoleR = 6.2 / 2;
screwHoleOffsetX = -14;

screwHoleR2 = 5.4 / 2;
screwHoleOffsetY2 = -8;

// Calculated
bracketOuterR = bracketInnerR + bracketWallWidth;

// Design
module body() {
    bracket(true);
    
    translate([0, -5, 0])
    rotate([0, 0, 180])
    bracket(false);
}

module bracket(with_arm) {
    difference() {
        full_bracket(with_arm);
        
        // half
        translate([-bracketWidth /2 - 1, -bracketOuterR, -1]) // fix: 0.01, rendering
        cube([bracketWidth + armLength + 2, bracketOuterR, bracketHeight + armHeight + 2]);
    }
}

module full_bracket(with_arm) {
    difference() {
        union() {    
            k = with_arm ? 0 : armHeight;

            if (with_arm) {
                arm();
            }
            
            cylinder(r = bracketOuterR, h = bracketHeight + k);
            
            translate([-bracketWidth / 2, -bracketWallWidth])
            cube([bracketWidth, 2 * bracketWallWidth, bracketHeight + k]);
        }
        
        translate([0, 0, -1])
        cylinder(r = bracketInnerR, h = bracketHeight + armHeight + 2);
        
        // screw holes
        screw_hole();
        screw_hole2();
        
    }
}


module arm() {
    difference() {
        translate([-bracketWidth / 2, 0, bracketHeight])
        cube([bracketWidth + armLength, bracketOuterR, armHeight]);
       
        // screw hole
        translate([bracketWidth / 2 + armLength + screwHoleOffsetX, bracketOuterR / 2, bracketHeight - 1])
        cylinder(r = screwHoleR, h = armHeight + 2);
        
        translate([bracketWidth / 2 + armLength + screwHoleOffsetX, bracketOuterR / 2, bracketHeight - 1])
        cylinder(r = screwHoleR + 2, h = 2); // fix: screw head

    }
}

module screw_hole() {
        translate([bracketWidth / 2 + screwHoleOffsetY2, bracketWallWidth + 1, bracketHeight/2])
        rotate([90, 0, 0])
        cylinder(r = screwHoleR2, h = bracketWallWidth + 2);
}

module screw_hole2() {
        translate([-bracketWidth / 2 - screwHoleOffsetY2, bracketWallWidth + 1, bracketHeight/2])
        rotate([90, 0, 0])
        cylinder(r = screwHoleR2, h = bracketWallWidth + 2);
}

body();