//Written by Ryan Branch on 7/8/2017
//Default values are listed in inches

//Special variables:
$fn = 50;

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
    translate([0,0,(vthick_bottom_plate / 2)]) {
        cube([turntable_width, turntable_width, vthick_bottom_plate], true);
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
        }
    }
}