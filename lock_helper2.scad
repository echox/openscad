use <lib/polyScrewThread_r1.scad>;

// settings
spacing=50;

box_x=30;
box_y=15;
box_z_bottom=15;
box_z_top=10;
leash_width=2;
leash_depth=5;
leash_length=30;
leash_height=40;
box_space=30;

// screw settings
diameter=8;
stepPerTurn=2;
toothDegree=55;
length=40;
resolution=PI/2;

cupSize=10;
cupHeight=3;

//calced settings / constants
PI=3.141592;
height = box_z_bottom + box_z_top + box_space;
middle_y = box_y/2 - leash_width/2;

// documentation for screw module
/* screw_thread(15,   // Outer diameter of the thread
 *               4,   // Step, traveling length per turn, also, tooth height, whatever...
 *              55,   // Degrees for the shape of the tooth 
 *                       (XY plane = 0, Z = 90, btw, 0 and 90 will/should not work...)
 *             100,   // Length (Z) of the tread
 *            PI/2,   // Resolution, one face each "PI/2" mm of the perimeter, 
 *               0);  // Countersink style:
 *                         -2 - Not even flat ends
 *                         -1 - Bottom (countersink'd and top flat)
 *                          0 - None (top and bottom flat)
 *                          1 - Top (bottom flat)
 *                          2 - Both (countersink'd)
 */

// modules

module create_box1() {
	//upper
	cube([box_x, box_y, box_z_top]);
}

module create_box2(){
	//bottom
	cube([box_x, box_y, box_z_bottom]);
}

module create_screw_cup() {
	cylinder(h=cupHeight,r=cupSize/2,$fn=30);
}

module create_screw() {
	union() {
 		screw_thread(diameter,stepPerTurn,toothDegree,length,resolution,1);
		translate([0,0,cupHeight*-1]) create_screw_cup();
	}
}

module create_leash() {
	union() {
		cube([leash_length,leash_width,leash_width]);
		cube([leash_depth,leash_height,leash_width]);
	}
}

// objects

//bottom
difference() {
	create_box2();
	//leash
	translate([0,middle_y,0]) cube([leash_depth,leash_width,height]);
	//screw
	translate([(box_x/3*2),middle_y,-5]) create_screw();
}

//top
difference() {
	translate([spacing,0,0]) create_box1();
	//leash
	translate([spacing,middle_y,0]) cube([leash_depth,leash_width,height]);
	//screw cup
	translate([spacing+((box_x/3*2)),middle_y,box_z_top-cupHeight/2]) create_screw_cup();
}

//screw
translate([0,spacing,0]) create_screw();

//leash
translate([spacing*-1,0,0]) create_leash();
