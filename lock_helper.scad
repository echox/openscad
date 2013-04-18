use </home/echox/openscad/Thread_Library.scad>;

// thread module
// metric_thread(diameter, pitch, length)

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

module create_boxes() {
	//upper
	translate([0,0,box_space]) cube([box_x, box_y, box_z_bottom]);

	//bottom
	cube([box_x, box_y, box_z_top]);
}

// object
difference() {
	create_boxes();

	//leash
	translate([0,middle_y,0]) cube([leash_depth,leash_width,height]);
}

translate([20,20,20]) metric_thread(2, 0.4, 20) cube([10,10,100]);