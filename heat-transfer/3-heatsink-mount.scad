//Created by Ryan Branch on 16 October 2017
//Makes use of roundedcube_simple, which was
//written by Daniel Upshaw A.K.A. GrooverNectar.
//More info here: https://danielupshaw.com/openscad-rounded-corners/

//V A R I A B L E S
//All units are millimeters unless otherwise specified

//N O T E S   F O R   O N S H A P E
//When attempting to create this object, it may be useful
//to know the following: (TRUE AS OF 17 OCTOBER 2017 EDIT)
// - fin "space length" = 1.900 mm
//       "tile length"  = 2.550 mm
// - row "space length" = 2.260 mm
// -     "tile length"  = 10.460 mm

//HEATSINK PROPERTIES
heatsink_width_parallel = 60.90;
heatsink_width_perpendicular = 60.40;
fin_height = 25.00;
fins_per_row = 24;
num_rows = 6;
//PART PROPERTIES
part_height = 5.0; //A LOT IS BASED ON THIS NUMBER. (PART_HEIGHT)
heatsink_in = 3.0; //USE HEATSINK_IN INSTEAD FOR CHANGES
cap_height = 4.5;
part_width_parallel = 70.00;
part_width_perpendicular = 70.00;
finTolerance = 0.80;
rowTolerance = 1.20;

//CURRENT GUESSES
fin_width = 0.65;
row_width = 8.20;

//MOUNT POSITIONING, SET
x_offset_left = -55.5;
y_offset_left = 57.5;
z_offset_left = 0;
x_offset_right = -64.5;
y_offset_right = -57.5;
z_offset_right = 7;
top_thickness = 5;
//MOUNT POSITIONING, CALCULATED

//The rows all line up with the heatsink edge.
//The fins at each end have half a "fin space" at each edge.
//This means that there are effectively (num_rows - 1) row spaces
// and (fins_per_row) fin spaces (with one space being divided in half)
finSpaceWidth = (heatsink_width_perpendicular - (fins_per_row * fin_width)) / fins_per_row;
rowSpaceWidth = (heatsink_width_parallel - (num_rows * row_width)) / (num_rows - 1);



//G L O B A L
$fn = 120;




// M O D U L E S
// M O D U L E S
// M O D U L E S

//groovenectar's roundedcube_simple.scad
module roundedcube_simple(size = [1, 1, 1], center = false, radius = 0.5) {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate = (center == false) ?
		[radius, radius, radius] :
		[
			radius - (size[0] / 2),
			radius - (size[1] / 2),
			radius - (size[2] / 2)
	];

	translate(v = translate)
	minkowski() {
		cube(size = [
			size[0] - (radius * 2),
			size[1] - (radius * 2),
			size[2] - (radius * 2)
		]);
		sphere(r = radius);
	}
}



// P A R T
// P A R T
// P A R T
union() {

//SECTION 1: Forms the rounded profile which connects each heatsink negative plate
difference() {
    union (){
        //The cylinder path connecting left to middle
        translate([-20.5, 37, z_offset_right/2]) {
            cylinder(part_width_parallel + z_offset_right, 23, 23, true);
        }
        //The cylinder path connecting middle to right
        translate([-20.5, -37, z_offset_right/2]) {
            cylinder(part_width_parallel + z_offset_right, 23, 23, true);
        }
    }
    
    //REMOVING HEATSINK PLATE CUBES SO THEY CAN BE REPLACED LATER
    //TOP
    rotate([0, 90, 0]) {
        cube([part_width_parallel, part_width_perpendicular, part_height * 2], true);
    }
    //LEFT
    translate([x_offset_left, y_offset_left, 0]) {
    rotate([0, 90, 90]) {
        cube([part_width_parallel, part_width_perpendicular, part_height * 2], true);
        }
    }
    //RIGHT
    translate([x_offset_right, y_offset_right, z_offset_right]) {
        rotate([0, 90, -90]) {
            translate([z_offset_right/2, 0, 0]) {
                cube([part_width_parallel + z_offset_right, part_width_perpendicular, part_height * 2], true);
            }
        }
    }
    
    //Central "roundedcube" subtracted to rid the rest of cylinders
    //NOTE: 110 == ((57.5 - (5 / 2)) * 2)
    translate([-57.5, 0, 0]) {
        roundedcube_simple([110, 110, part_width_parallel * 2], true, 18);
    }    
}





//SECTION 2: EXTRA RECTANGLES FOR WHOLENESS
//These are specifically determined based on corner radius sizing and positioning.
//Between LEFT and MIDDLE
translate([(heatsink_in / -2), 36, (z_offset_right + top_thickness)/2]) {
    cube([(part_height + heatsink_in), 2, part_width_parallel + z_offset_right + top_thickness], true);
}
//Between MIDDLE and RIGHT
translate([(heatsink_in / -2), -36, (z_offset_right + top_thickness)/2]) {
    cube([(part_height + heatsink_in), 2, part_width_parallel + z_offset_right + top_thickness], true);
}
//"TOP" (Closer to MIDDLE) end of RIGHT
translate([-25, -57.5 + (heatsink_in / 2), (z_offset_right + top_thickness)/2]) {
    cube([9, (part_height + heatsink_in), part_width_parallel + z_offset_right + top_thickness], true);
}
//At FAR END OF LEFT
translate([-95, 57.5 - (heatsink_in / 2), (z_offset_right + top_thickness)/ 2]) {
    cube([9, (part_height + heatsink_in), part_width_parallel + z_offset_right + top_thickness], true);
}
//RECTANGLE COLUMNS FOR BLOCKING AIRFLOW
//LEFT SIDE
//X axis aligned rectangle column
//46 = 55 - 9
//20.5 = 5 + 18 - 2.5
translate([-20.5, 46, (z_offset_right + top_thickness)/ 2]) {
    cube([5, 18, part_width_parallel + z_offset_right + top_thickness], true);
}
//Y axis aligned (Just ADD 9 to X, SUBTRACT 9 from Y), SWAP X/Y DIMS
//39.5 = (46 - 9) + 2.5
translate([-11.5, 39.5, (z_offset_right + top_thickness)/ 2]) {
    cube([18, 5, part_width_parallel + z_offset_right + top_thickness], true);
}
//RIGHT SIDE
//Just make Y's TRANSLATIONS opposite
//X axis aligned rectangle column
translate([-20.5, -46, (z_offset_right + top_thickness)/ 2]) {
    cube([5, 18, part_width_parallel + z_offset_right + top_thickness], true);
}
//Y axis aligned (Just ADD 9 to X, SUBTRACT 9 from Y), SWAP X/Y DIMS
translate([-11.5, -39.5, (z_offset_right + top_thickness)/ 2]) {
    cube([18, 5, part_width_parallel + z_offset_right + top_thickness], true);
}





//SECTION 3: The HEATSINK MOUNT ASSEMBLIES
//The top "heatsink mount assembly"
rotate([0, 90, 0]) {
        difference() {
        //This first object is the base from which the others are subtracted
        translate([(z_offset_right + top_thickness)/-2, 0, (heatsink_in / -2)]) {
            cube([part_width_parallel + z_offset_right + top_thickness, part_width_perpendicular, part_height + heatsink_in], true);
        }
        
        //This loop describes removal of parallel strips
        for (fin=[0:fins_per_row - 1]) {
            translate([0,
                       (heatsink_width_perpendicular / 2) - (fin_width * 1.5) - (fin * (fin_width + finSpaceWidth)),
                       (cap_height + heatsink_in) / -2]) {
                cube([heatsink_width_parallel,
                      fin_width + finTolerance,
                      part_height - cap_height + heatsink_in], true);
            }
        }
    }
}

//The left "heatsink mount assembly" (viewed from behind)
translate([-55.5, 57.5, 0]) {
    rotate([0, 90, 90]) {
        difference() {
            //This first object is the base from which the others are subtracted
            translate([(z_offset_right + top_thickness)/-2, 0, (heatsink_in / -2)]) {
                cube([part_width_parallel + z_offset_right + top_thickness, part_width_perpendicular, part_height + heatsink_in], true);
            }
            
            //This loop describes removal of parallel strips
            for (fin=[0:fins_per_row - 1]) {
                translate([0,
                           (heatsink_width_perpendicular / 2) - (fin_width * 1.5) - (fin * (fin_width + finSpaceWidth)),
                           (cap_height + heatsink_in) / -2]) {
                    cube([heatsink_width_parallel,
                          fin_width + finTolerance,
                          part_height - cap_height + heatsink_in], true);
                }
            }
        }
    }
}

//The right "heatsink mount assembly" (viewed from behind)
translate([-64.5, -57.5, z_offset_right]) {
    rotate([0, 90, -90]) {
        difference() {
            //This first object is the base from which the others are subtracted
            translate([(z_offset_right - top_thickness)/2, 0, (heatsink_in / -2)]) {
                cube([part_width_parallel + z_offset_right + top_thickness, part_width_perpendicular, part_height + heatsink_in], true);
            }
            
            //This loop describes removal of parallel strips
            for (fin=[0:fins_per_row - 1]) {
                translate([0,
                           (heatsink_width_perpendicular / 2) - (fin_width * 1.5) - (fin * (fin_width + finSpaceWidth)),
                           (cap_height + heatsink_in) / -2]) {
                    cube([heatsink_width_parallel,
                          fin_width + finTolerance,
                          part_height - cap_height + heatsink_in], true);
                }
            }
        }
    }
}

//SECTION 4: Columns for blocking (MOST) air
//This translate places the center line at (top_thickness/2) above the actual part
//This is a direct Z shift from the origin
translate([0, 0, (part_width_parallel + top_thickness) / 2 + z_offset_right]) {
    difference() {
        union (){
            //The cylinder path connecting left to middle
            translate([-20.5, 37, 0]) {
                cylinder(top_thickness, 23, 23, true);
            }
            //The cylinder path connecting middle to right
            translate([-20.5, -37, 0]) {
                cylinder(top_thickness, 23, 23, true);
            }
        }
        //Subtracted to remove cylinder half with X axis split
        //20.5 = 18 + 2.5
        translate([-20.5, 0, 0]) {
            //74 = 110 - 2(18)
            //46 = 2(18) + 2(5)
            cube([46,74,top_thickness], true);
        }
        //Subtracted to remove cylinder half with Y axis split
        //38.5 = 2(18) + 2.5
        translate([-38.5, 0, 0]) {
            //120 = 110 + 2(5)
            //36 = 2(18)
            cube([36,120,top_thickness], true);
        }
    }
}

}//OUTER UNION