use <lib/Thread_Library.scad>;

// settings
box_x=30;
box_y=15;
box_z_bottom=10;
box_z_top=15;
leash_width=2;
leash_depth=5;
box_space=30;


//calced settings
height = box_z_bottom + box_z_top + box_space;
middle_y = box_y/2 - leash_width/2;


// screw settings
length=50;
pitch=4;
pitchRadius=4; 


// modules

module create_boxes() {
	//upper
	translate([0,0,box_space]) cube([box_x, box_y, box_z_bottom]);

	//bottom
	cube([box_x, box_y, box_z_top]);
}

module create_screw() {
union() {
translate([0,0,0]) cylinder(h=5,r=5);
translate([0,0,-50])
trapezoidThread(
        length=length,
        pitch=pitch,
        pitchRadius=pitchRadius,
        threadHeightToPitch=0.5,
        profileRatio=0.5,
        threadAngle=30,
        RH=false,
        clearance=0.1,
        backlash=0.1,
        stepsPerTurn=24);
}
}

module create_hole() {
trapezoidThreadNegativeSpace(
        length=length,
        pitch=pitch,
        pitchRadius=pitchRadius,
        threadHeightToPitch=0.5,
        profileRatio=0.5,
        threadAngle=30,
        RH=false,
        clearance=0.1,
        backlash=0.1,
        stepsPerTurn=24);
}

// object
difference() {
	create_boxes();

	//leash
	translate([0,middle_y,0]) cube([leash_depth,leash_width,height]);

	translate([(box_x/3*2),middle_y,box_space-3]) create_screw();

}

