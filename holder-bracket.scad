$fn = 200;

// Parameters
clipMountWidth = 100 + 1;
clipMountDepth = 14;
clipMountHeight = 5;

clipArmLength = 90;
clipArmWidth = 4;

screwHoleR = 6.2 / 2;
screwBaseExtraHeight = 2;

screwHoleR2 = 5.4 / 2;
screwHoleOffsetY = -8;
screwBaseExtraHeight2 = 1;

triangleHeight = 14;

// Calculated
clipArmDepth = clipMountDepth;

// Design
module body() {
    bracket_base();
    
    bracket_arm();
               
    rotate([0, 0, 180])
    bracket_arm();
}

module bracket_base() {
    difference() {
        union() {
            translate([-clipMountWidth/2, -clipMountDepth/2, 0])
            cube([clipMountWidth, clipMountDepth, clipMountHeight]);
            
            translate([-clipMountDepth/2, -clipMountDepth/2, -screwBaseExtraHeight/2])
            cube([clipMountDepth, clipMountDepth, clipMountHeight + screwBaseExtraHeight]);
        }
        
        translate([0,0,-screwBaseExtraHeight])
        cylinder(r = screwHoleR, h = clipMountHeight + screwBaseExtraHeight + 2);
    }
}

module bracket_arm() {
    difference() {
        union() {
            translate([clipMountWidth/2, -clipArmDepth/2, 0])
            cube([clipArmWidth, clipArmDepth, clipArmLength]);
            
            translate([clipMountWidth/2 - screwBaseExtraHeight2/2, -clipArmDepth/2, clipArmLength - clipArmDepth])
            cube([clipArmWidth + screwBaseExtraHeight2, clipArmDepth, clipArmDepth]);
            
            bracket_triangle();
        }
        
        translate([clipMountWidth/2 - 2, 0, clipArmLength + screwHoleOffsetY])
        rotate([0, 90, 0])
        cylinder(r = screwHoleR2, h = clipArmWidth + 4);
    }
}

module bracket_triangle() {
    translate([clipMountWidth / 2,0, 0]) {
        rotate(a=[90,-90,0])
        linear_extrude(height = clipMountDepth, center = true, convexity = 10, twist = 0)
        polygon(points=[[0,0],[triangleHeight,0],[0,triangleHeight]], paths=[[0,1,2]]);
    }
}

body();

