//Written by Ryan Branch on 7/8/2017
//Default values are listed in inches

//Special variables:
$fn = 50;


//roundedCube.scad by GitHub user Sembiance

module roundedCube(dim, r=1, x=false, y=false, z=true, xcorners=[true,true,true,true], ycorners=[true,true,true,true], zcorners=[true,true,true,true], center=false, $fn=128)
{
	translate([(center==true ? (-(dim[0]/2)) : 0), (center==true ? (-(dim[1]/2)) : 0), (center==true ? (-(dim[2]/2)) : 0)])
	{
		difference()
		{
			cube(dim);

			if(z)
			{
				translate([0, 0, -0.1])
				{
					if(zcorners[0])
						translate([0, dim[1]-r]) { rotateAround([0, 0, 90], [r/2, r/2, 0]) { meniscus(h=dim[2], r=r, fn=$fn); } }
					if(zcorners[1])
						translate([dim[0]-r, dim[1]-r]) { meniscus(h=dim[2], r=r, fn=$fn); }
					if(zcorners[2])
						translate([dim[0]-r, 0]) { rotateAround([0, 0, -90], [r/2, r/2, 0]) { meniscus(h=dim[2], r=r, fn=$fn); } }
					if(zcorners[3])
						rotateAround([0, 0, -180], [r/2, r/2, 0]) { meniscus(h=dim[2], r=r, fn=$fn); }
				}
			}

			if(y)
			{
				translate([0, -0.1, 0])
				{
					if(ycorners[0])
						translate([0, 0, dim[2]-r]) { rotateAround([0, 180, 0], [r/2, 0, r/2]) { rotateAround([-90, 0, 0], [0, r/2, r/2]) { meniscus(h=dim[1], r=r); } } }
					if(ycorners[1])
						translate([dim[0]-r, 0, dim[2]-r]) { rotateAround([0, -90, 0], [r/2, 0, r/2]) { rotateAround([-90, 0, 0], [0, r/2, r/2]) { meniscus(h=dim[1], r=r); } } }
					if(ycorners[2])
						translate([dim[0]-r, 0]) { rotateAround([-90, 0, 0], [0, r/2, r/2]) { meniscus(h=dim[1], r=r); } }
					if(ycorners[3])
						rotateAround([0, 90, 0], [r/2, 0, r/2]) { rotateAround([-90, 0, 0], [0, r/2, r/2]) { meniscus(h=dim[1], r=r); } }
				}
			}

			if(x)
			{
				translate([-0.1, 0, 0])
				{
					if(xcorners[0])
						translate([0, dim[1]-r]) { rotateAround([0, 90, 0], [r/2, 0, r/2]) { meniscus(h=dim[0], r=r); } }
					if(xcorners[1])
						translate([0, dim[1]-r, dim[2]-r]) { rotateAround([90, 0, 0], [0, r/2, r/2]) { rotateAround([0, 90, 0], [r/2, 0, r/2]) { meniscus(h=dim[0], r=r); } } }
					if(xcorners[2])
						translate([0, 0, dim[2]-r]) { rotateAround([180, 0, 0], [0, r/2, r/2]) { rotateAround([0, 90, 0], [r/2, 0, r/2]) { meniscus(h=dim[0], r=r); } } }
					if(xcorners[3])
						rotateAround([-90, 0, 0], [0, r/2, r/2]) { rotateAround([0, 90, 0], [r/2, 0, r/2]) { meniscus(h=dim[0], r=r); } }
				}
			}
		}
	}
}

module meniscus(h, r, fn=128)
{
	$fn=fn;

	difference()
	{
		cube([r+0.2, r+0.2, h+0.2]);
		translate([0, 0, -0.1]) { cylinder(h=h+0.4, r=r); }
	}
}

module rotateAround(a, v) { translate(v) { rotate(a) { translate(-v) { children(); } } } }


//User-defined parameters:
    //TURNTABLE SPECIFICATIONS
    turntable_width = 3.000;
    turntable_thickness = 0.390;
    turntable_top_hole_spacing = 2.560;
    turntable_top_hole_diameter = 0.160;
    turntable_bottom_hole_spacing = 2.560;
    turntable_bottom_hole_diameter = 0.160;
    turntable_central_hole_diameter = 2.710;
    //MOTOR SPECIFICATIONS
    motor_width = 1.700;
    motor_body_height = 1.950;
    motor_raised_circle_height = 0.090;
    motor_raised_circle_diameter = 0.880;
    motor_hole_spacing = 1.220;
    motor_hole_diameter = 0.160;
    motor_shaft_length = 0.945;
    motor_shaft_diameter = 0.208;
	motor_wire_exit_width = 0.510;
    motor_wire_exit_height = 0.510;
    //Thickness of extra space for sliding wire between motor wall and part wall
    motor_wire_clearance_width = 0.250;
    //The distance above the motor face plate that any component sticks out
    motor_clearance_height = 0.2;
    //FASTENER SPECIFICATIONS
    outside_bottom_nut_thickness = 0.080;
    outside_bottom_nut_largest_diameter = 0.270;
    inside_bottom_nut_thickness = 0.080;
    inside_bottom_nut_largest_diameter = 0.270;
    top_nut_thickness = 0.080;
    top_nut_largest_diameter = 0.270;

//Writer-defined parameters:
    //BOTTOM PARAMETERS
    
    //LOWER BRACKET PARAMETERS
    //horizontal thicknesses
    hthick_lower_bracket_walls = 0.500;
    
    //UPPER BRACKET PARAMETERS
    //vertical thicknesses
    vthick_bottom_plate = 0.250;
    vthick_upper_bracket_plate = 0.125;
    vthick_top_plate = 0.250;
    vthick_space_below_coupler = 0.100;
    //"below" refers to after the part has been flipped over 180 degrees
    vthick_below_vents = 0.250;
    //horizontal thicknesses
    hthick_shaft_coupler_ring = 0.125;
    hthick_shaft_coupler_panel = 0.100;
    hthick_shaft_coupler_gap = 0.03;
    //other
    shaft_coupler_panel_length = 0.300;
    shaft_coupler_hole_diameter = 0.160;
    
    //TOP PARAMETERS

//Part 1: Bottom Plate
// - This part is connected to the motor body via the motor holes
// - This part is connected to the turntable via the turntable bottom holes,
//    through the Lower Mounting Bracket
difference() {
    //Create the bottom plate, horizontally centered but vertically at 0
    //translate([0,0,(vthick_bottom_plate / 2)]) {
    //    cube([turntable_width, turntable_width, //vthick_bottom_plate], true);
    //}
    translate([0, 0, vthick_bottom_plate / 2]) {
        roundedCube([turntable_width, turntable_width, vthick_bottom_plate], r=0.25, x=false, y=false, z=true, xcorners=[true,true,true,true], ycorners=[true,true,true,true], zcorners=[true,true,true,true], center=true, $fn=128);
    }
    
    //Holes, defined as cylinders which are then subtracted from the bottom plate
    for(xMultiplier = [-1:2:1]) {
        for(yMultiplier = [-1:2:1]) {
            //Holes for attaching to turntable
            translate([(xMultiplier * (turntable_bottom_hole_spacing / 2)),
                       (yMultiplier * (turntable_bottom_hole_spacing / 2)),
                       0]) {
                cylinder(vthick_bottom_plate,
                         (turntable_bottom_hole_diameter / 2),
                         (turntable_bottom_hole_diameter / 2));
            }
            //Spaces for nuts involved in attachment to turntable
            translate([(xMultiplier * (turntable_bottom_hole_spacing / 2)),
                       (yMultiplier * (turntable_bottom_hole_spacing / 2)),
                       (vthick_bottom_plate - outside_bottom_nut_thickness)]) {
                cylinder((outside_bottom_nut_thickness),
                         (outside_bottom_nut_largest_diameter / 2),
                         (outside_bottom_nut_largest_diameter / 2));
            }
            
            //Holes for attaching to motor
            translate([(xMultiplier * (motor_hole_spacing / 2)),
                       (yMultiplier * (motor_hole_spacing / 2)),
                       0]) {
                cylinder(vthick_bottom_plate,
                         (motor_hole_diameter / 2),
                         (motor_hole_diameter / 2));
            }
            //Spaces for nuts involved in attachment to turntable
            translate([(xMultiplier * (motor_hole_spacing / 2)),
                       (yMultiplier * (motor_hole_spacing / 2)),
                       (vthick_bottom_plate - inside_bottom_nut_thickness)]) {
                cylinder((inside_bottom_nut_thickness),
                         (inside_bottom_nut_largest_diameter / 2),
                         (inside_bottom_nut_largest_diameter / 2));
            }
        }
    }
}
