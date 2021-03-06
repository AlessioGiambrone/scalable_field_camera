// loading the base configuration
include <baseconfig.scad>;

// some modules such as hex, countersunk screws, roof, wedge are available in a module file
use <modules.scad>;



// we are centering our cube
vLowerCube_l = vBellowsBackFrameOuter_l;
vLowerCube_w = vLowerCube_l;
vLowerCube_h = vBellowsBackFrameOuter_h;
vLowerCube_offsetX = -vLowerCube_l/2;
vLowerCube_offsetY = -vLowerCube_w/2;
vLowerCube_offsetZ = 0;

// we build our pyramid as cone with 4 segments
vMiddlePyramid_d1 = sqrt(2*pow(vBellowsBackFrameOuter_l,2));
vMiddlePyramid_d2 = sqrt(2*pow(vBellowsBackLightTrapOuter_l,2));
vMiddlePyramid_h = vBellowsBackFrameInner_h;
vMiddlePyramid_offsetX = 0;
vMiddlePyramid_offsetY = 0;
vMiddlePyramid_offsetZ = vLowerCube_h;

vUpperCube_l = vBellowsBackLightTrapOuter_l;
vUpperCube_w = vBellowsBackLightTrapOuter_w;
vUpperCube_h = vBellowsBackLightTrap_h;
vUpperCube_offsetX = -vUpperCube_l/2;
vUpperCube_offsetY = -vUpperCube_w/2;
vUpperCube_offsetZ = vLowerCube_h+vMiddlePyramid_h;

vInnerCutout_l = vBellowsBackFrameInner_l;
vInnerCutout_w = vBellowsBackFrameInner_l;
vInnerCutout_h = vLowerCube_h+vMiddlePyramid_h+vUpperCube_h;
vInnerCutout_offsetX = -vInnerCutout_l/2;
vInnerCutout_offsetY = -vInnerCutout_w/2;
vInnerCutout_offsetZ = 0;

vSplitCutoutOuter_l = vBellowsBackOuter_l;
vSplitCutoutOuter_w = vBellowsBackOuter_w;
vSplitCutoutOuter_h = vInnerCutout_h;
vSplitCutoutOuter_offsetX = -vSplitCutoutOuter_l/2;
vSplitCutoutOuter_offsetY = -vSplitCutoutOuter_w/2;
vSplitCutoutOuter_offsetZ = 0.2;

vSplitCutoutInner_l = vBellowsBackInner_l;
vSplitCutoutInner_w = vBellowsBackInner_w;
vSplitCutoutInner_h = vInnerCutout_h;
vSplitCutoutInner_offsetX = -vSplitCutoutInner_l/2;
vSplitCutoutInner_offsetY = -vSplitCutoutInner_w/2;
vSplitCutoutInner_offsetZ = 0.2;

vBellowsScrew_d = 2.5;
vBellowsScrew_h = 20;
vBellowsScrew_offsetX = (vLowerCube_l)/2;
vBellowsScrew_offsetY = (vLowerCube_l)/2-40;
vBellowsScrew_offsetZ = vLowerCube_h/2;

// screw holes for fixing the whole frame in the body
vBellowsBackFrameScrewHole_offsetX = (vLowerCube_l)/2;
vBellowsBackFrameScrewHole_offsetY = vBellowsBackFrameScrewHole_offsetXY;

difference(){
    union(){
        // lower cube
        translate([vLowerCube_offsetX, vLowerCube_offsetY, vLowerCube_offsetZ])
            cube([vLowerCube_l, vLowerCube_w, vLowerCube_h]);
        
        // middle pyramid
        translate([vMiddlePyramid_offsetX, vMiddlePyramid_offsetY, vMiddlePyramid_offsetZ])
            rotate([0, 0, 45])
                cylinder(d1=vMiddlePyramid_d1, d2=vMiddlePyramid_d2, h=vMiddlePyramid_h, $fn=4);
        
        // upper cube
        translate([vUpperCube_offsetX, vUpperCube_offsetY, vUpperCube_offsetZ])
            cube([vUpperCube_l, vUpperCube_w, vUpperCube_h]);
        
        };
    
    // split cutout
    difference(){
        // split cutout outer cube
        translate([vSplitCutoutOuter_offsetX, vSplitCutoutOuter_offsetY, vSplitCutoutOuter_offsetZ])
            cube([vSplitCutoutOuter_l, vSplitCutoutOuter_w, vSplitCutoutOuter_h]);
        
        // split cutout inner cube
        translate([vSplitCutoutInner_offsetX, vSplitCutoutInner_offsetY, vSplitCutoutInner_offsetZ])
            cube([vSplitCutoutInner_l, vSplitCutoutInner_w, vSplitCutoutInner_h]);
        }

    // inner cutout cube
        translate([vInnerCutout_offsetX, vInnerCutout_offsetY, vInnerCutout_offsetZ])
            cube([vInnerCutout_l, vInnerCutout_w, vInnerCutout_h]);
        
    // inner screw holes (countersunk screws)
    // screws in x/-x direction    
    translate([vBellowsScrew_offsetX, vBellowsScrew_offsetY, vBellowsScrew_offsetZ])
        rotate([0, -90, 0])
            countersunk_screw(vBellowsScrew_d, vBellowsScrew_h);
    translate([vBellowsScrew_offsetX, -vBellowsScrew_offsetY, vBellowsScrew_offsetZ])
        rotate([0, -90, 0])
            countersunk_screw(vBellowsScrew_d, vBellowsScrew_h);
    translate([-vBellowsScrew_offsetX, vBellowsScrew_offsetY, vBellowsScrew_offsetZ])
        rotate([0, 90, 0])
            countersunk_screw(vBellowsScrew_d, vBellowsScrew_h);
    translate([-vBellowsScrew_offsetX, -vBellowsScrew_offsetY, vBellowsScrew_offsetZ])
        rotate([0, 90, 0])
            countersunk_screw(vBellowsScrew_d, vBellowsScrew_h);
    
    // screws in y/-y direction    
    translate([vBellowsScrew_offsetY, vBellowsScrew_offsetX, vBellowsScrew_offsetZ])
        rotate([90, 0, 0])
            countersunk_screw(vBellowsScrew_d, vBellowsScrew_h);
    translate([vBellowsScrew_offsetY, -vBellowsScrew_offsetX, vBellowsScrew_offsetZ])
        rotate([-90, 0, 0])
            countersunk_screw(vBellowsScrew_d, vBellowsScrew_h);
    translate([-vBellowsScrew_offsetY, vBellowsScrew_offsetX, vBellowsScrew_offsetZ])
        rotate([90, 0, 0])
            countersunk_screw(vBellowsScrew_d, vBellowsScrew_h);
    translate([-vBellowsScrew_offsetY, -vBellowsScrew_offsetX, vBellowsScrew_offsetZ])
        rotate([-90, 0, 0])
            countersunk_screw(vBellowsScrew_d, vBellowsScrew_h);    
    
    // outer screw holes 
    // screws in x/-x direction    
    translate([vBellowsBackFrameScrewHole_offsetX, vBellowsBackFrameScrewHole_offsetY, vBellowsBackFrameScrewHole_offsetZ])
        rotate([0, -90, 0])
            cylinder(d=vBellowsBackFrameScrewHole_d, h=vBellowsBackFrameScrewHole_h);
    translate([vBellowsBackFrameScrewHole_offsetX, -vBellowsBackFrameScrewHole_offsetY, vBellowsBackFrameScrewHole_offsetZ])
        rotate([0, -90, 0])
            cylinder(d=vBellowsBackFrameScrewHole_d, h=vBellowsBackFrameScrewHole_h);
    translate([-vBellowsBackFrameScrewHole_offsetX, vBellowsBackFrameScrewHole_offsetY, vBellowsBackFrameScrewHole_offsetZ])
        rotate([0, 90, 0])
            cylinder(d=vBellowsBackFrameScrewHole_d, h=vBellowsBackFrameScrewHole_h);
    translate([-vBellowsBackFrameScrewHole_offsetX, -vBellowsBackFrameScrewHole_offsetY, vBellowsBackFrameScrewHole_offsetZ])
        rotate([0, 90, 0])
            cylinder(d=vBellowsBackFrameScrewHole_d, h=vBellowsBackFrameScrewHole_h);
    
    // screws in y/-y direction    
    translate([vBellowsBackFrameScrewHole_offsetY, vBellowsBackFrameScrewHole_offsetX, vBellowsBackFrameScrewHole_offsetZ])
        rotate([90, 0, 0])
            cylinder(d=vBellowsBackFrameScrewHole_d, h=vBellowsBackFrameScrewHole_h);
    translate([vBellowsBackFrameScrewHole_offsetY, -vBellowsBackFrameScrewHole_offsetX, vBellowsBackFrameScrewHole_offsetZ])
        rotate([-90, 0, 0])
            cylinder(d=vBellowsBackFrameScrewHole_d, h=vBellowsBackFrameScrewHole_h);
    translate([-vBellowsBackFrameScrewHole_offsetY, vBellowsBackFrameScrewHole_offsetX, vBellowsBackFrameScrewHole_offsetZ])
        rotate([90, 0, 0])
            cylinder(d=vBellowsBackFrameScrewHole_d, h=vBellowsBackFrameScrewHole_h);
    translate([-vBellowsBackFrameScrewHole_offsetY, -vBellowsBackFrameScrewHole_offsetX, vBellowsBackFrameScrewHole_offsetZ])
        rotate([-90, 0, 0])
            cylinder(d=vBellowsBackFrameScrewHole_d, h=vBellowsBackFrameScrewHole_h);        

}