//Written by Ryan Branch on 7/8/2017
//Default values are listed in inches

//Special variables:
$fn = 50;

//User-defined parameters:
    //TURNTABLE SPECIFICATIONS
    turntable_width = 3.000;
    turntable_thickness = 0.390;
    turntable_top_hole_spacing = 2.560;
    turntable_top_hole_diameter = 0.17;
    turntable_bottom_hole_spacing = 2.560;
    turntable_bottom_hole_diameter = 0.17;
    turntable_central_hole_diameter = 2.710;
    //MOTOR SPECIFICATIONS
    motor_width = 1.700;
    motor_body_height = 1.950;
    motor_raised_circle_height = 0.090;
    motor_raised_circle_diameter = 0.880;
    motor_hole_spacing = 1.220;
    motor_hole_diameter = 0.160;
    motor_shaft_length = 0.945;
    motor_shaft_diameter = 0.210;
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
    hthick_shaft_coupler_ring = 0.188;
    hthick_shaft_coupler_panel = 0.100;
    hthick_shaft_coupler_gap = 0.03;
    //other
    shaft_coupler_panel_length = 0.300;
    shaft_coupler_hole_diameter = 0.160;
    
    //TOP PARAMETERS


//Part 3: Upper Bracket
// - This part is connected to the Top Plate as well as the
//    turntable top holes via the outside holes
// - Further, it contains a shaft coupler which is used to fasten the
//    part to the stepper motor. It is bt this mechanism that rotation
//    of the top plate is achieved, while the bottom plate remains fixed
union() {
    
//This first difference() is used to create the flat plate
//  portion of the bracket which attaches via threaded rod
difference() {
    //The height of the bracket's lower portion is
    //equal to the length of the motor's body.
    //It's created horizontally centered but vertically at 0
    translate([0,0,(vthick_upper_bracket_plate / 2)]) {
        cube([turntable_width, turntable_width, vthick_upper_bracket_plate], true);
    }
    
    //Holes which are subtracted from the lower portion
    for(xMultiplier = [-1:2:1]) {
        for(yMultiplier = [-1:2:1]) {
            //Holes for attaching to Bottom Plate
            translate([(xMultiplier * (turntable_bottom_hole_spacing / 2)),
                       (yMultiplier * (turntable_bottom_hole_spacing / 2)),
                       0]) {
                cylinder(motor_body_height,
                         (turntable_bottom_hole_diameter / 2),
                         (turntable_bottom_hole_diameter / 2));
            }
            
        }
    }
}   //difference()
 
//Some preliminary math work:
outerRadius = (motor_shaft_diameter) / 2 + hthick_shaft_coupler_ring;
radiusToPanel = outerRadius * 
                cos(asin((hthick_shaft_coupler_panel +          
                               (hthick_shaft_coupler_gap / 2)) / outerRadius));
 
//This second difference() is used to create the shaft coupler portion
difference() {
    //The height of the shaft coupler portion is somewhat arbitrarily made
    //  equal to the length of the motor's shaft,
    //  minus the thickness of the turntable.
    //  In actuality it simply must less than the length of the shaft
    union() {
        //The ring of the shaft coupler which grips the shaft
        translate([0,0,(motor_shaft_length +
                        vthick_upper_bracket_plate -
                        motor_clearance_height) / 2]) {
            cylinder((motor_shaft_length +
                      vthick_upper_bracket_plate -
                      motor_clearance_height),
                     (motor_shaft_diameter / 2) + hthick_shaft_coupler_ring,
                     (motor_shaft_diameter / 2) + hthick_shaft_coupler_ring,
                     true);
        }
    }


    //Cylindrical hole into which the motor shaft is inserted
    translate([0,0,(vthick_upper_bracket_plate +
                    ((motor_shaft_length - motor_clearance_height) / 2))]) {
        cylinder((motor_shaft_length - motor_clearance_height),
                 (motor_shaft_diameter / 2),
                 (motor_shaft_diameter / 2),
                 true);
    }
    
} //difference()

} //union()