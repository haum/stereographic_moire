simple_shadow = false;
show_A = true;
show_B = true;
show_C = true;

module shapeA() {
    ors = 57;
    irs = 52;
   translate([0, 0, 50+ors/2-30]) difference() {
        cube(ors, center=true);
        cube(irs, center=true);
    }
}

module shapeB() {
    ors = 55;
    irs = 50;
    translate([0, 0, 50+ors/2-20]) difference() {
        sphere(d=ors, $fa=1, $fs=1);
        sphere(d=irs, $fa=1, $fs=2);
    }
}

module shadow(name, w, h) {
    if (simple_shadow) {
        translate([-w/2, -h/2, 0]) square([w, h]);
	} else {
        translate([-w/2, -h/2, 0]) import(name);
    }
}

module A() {
    h = 100;
    p = 0.6;
    intersection() {
        shapeA();
        linear_extrude(h*p, scale=1-p) shadow("i1.dxf", 100, 100);
    }
    translate([0, 0, 60-3-7.5]) difference() {
        cube([57, 57, 15], center=true);
        cube([52, 52, 25], center=true);
    }
    translate([0, 0, 60-1.5]) difference() {
        cube([80, 80, 3], center=true);
        cube([52, 52, 25], center=true);
        for (i = [0:4]) rotate([0, 0, i*90]) translate([36, 36, 0]) cylinder(h=6, d=4, center=true, $fn=20);
    }
}

module B() {
    h = 100;
    p = 0.6;
    intersection() {
        shapeB();
        linear_extrude(h*p, scale=1-p) shadow("i2.dxf", 100, 100);
    }
    translate([0, 0, 60+1.5]) difference() {
        cube([80, 80, 3], center=true);
        cylinder(h=10, d=50, center=true, $fa=1, $fs=1);
        for (i = [0:4]) rotate([0, 0, i*90]) {
            translate([36, 36, 0]) cylinder(h=6, d=4, center=true, $fn=20);
            translate([72, 0, 0]) cylinder(h=6, d=83, center=true, $fn=60);
        }
    }
}

module C() {
    $fn = 40;
    difference() {
        union() {
            translate([0, 0, 100-4]) cylinder(h=8, d=20, center=true);
            for (i = [0:4]) rotate([0, 0, i*90]) translate([36, 36, 60+6-1.5]) {
                rotate([0,-140,45]) translate([0, -3.8, 0]) cube([60, 7.6, 5]);
                cylinder(h=3, d=8, center=true);
            }
        }
        for (i = [0:4]) rotate([0, 0, i*90]) translate([36, 36, 60+6-1.5]) {
            cylinder(h=6, d=4, center=true);
            translate([0, 0, 3-1.5]) cylinder(h=6, d=8);
        }
        translate([0,0,100]) cylinder(h=40, d=13, center=true);
        translate([0,0,60+3-1.5]) cube([80, 80, 3], center=true);
        translate([0,0,100+3-1.5]) cube([80, 80, 3], center=true);
    }
}

if (show_A) A();
if (show_B) B();
if (show_C) C();