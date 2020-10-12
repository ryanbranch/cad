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
    //vertical thicknesses
    vthick_stops = 0.125;
    
    //horizontal thicknesses
    hthick_top = 0.250;
    hthick_space_between_plates = 0.063;
    hthick_plates = 0.250;
    hthick_space_between_stops = 0.125;
    hthick_stops = 0.125;
    //other
    height_plates = 0.750;
    //The inner diameter of the curve is equal to this multiplier times hthick_top
    inner_diameter_multiplier = 3;
    

//PART 5: Top, with Grip

//main base
cube([turntable_width, hthick_top, turntable_width]);

//cylinder which becomes semicircular wall
translate([0,0,,
           0]) {
    cylinder(turntable_width,
             hthick_top * (inner_diameter_multiplier + 2) / 2,
             hthick_top * (inner_diameter_multiplier + 2) / 2);
}
