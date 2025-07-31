// Get Screen Dimensions (1920x1080)
var screen_width = display_get_width();
var screen_height = display_get_height();

// 🔹 Set Center of the Ring (Align with Pot)
var ui_x = screen_width / 2 - 310;
var ui_y = screen_height / 2 - 230;  // Adjust for pot alignment

var ring_radius = 250; // Base size of the ring
var thickness = 15; // Increase thickness by drawing multiple rings

draw_set_color(c_white);
for (var t = 0; t < thickness; t++) { // Draw multiple rings inside and outside
    for (var i = 0; i < 360; i += 3) {
        var x1 = ui_x + lengthdir_x(ring_radius - t, i);
        var y1 = ui_y + lengthdir_y(ring_radius - t, i);
        var x2 = ui_x + lengthdir_x(ring_radius - t, i + 3);
        var y2 = ui_y + lengthdir_y(ring_radius - t, i + 3);
        draw_line(x1, y1, x2, y2);
    }
}

// 🟢 **Draw Target Zone (Filled Green Indicator)**
draw_set_color(c_green);
var tx = ui_x + lengthdir_x(ring_radius, target_angle);
var ty = ui_y + lengthdir_y(ring_radius, target_angle);
draw_circle(tx, ty, 20, false); // **Now filled green**
draw_circle(tx, ty, 12, true);  // Small filled green center

// 🔴 **Draw Moving Stir Indicator (Red Circle with Hollow Center)**
draw_set_color(c_red);
var sx = ui_x + lengthdir_x(ring_radius, angle);
var sy = ui_y + lengthdir_y(ring_radius, angle);
draw_circle(sx, sy, 20, true); // Outer red ring (hollow)
draw_circle(sx, sy, 12, false);  // Small filled red center

// 🔹 **Display Stirs Counter (Inside Ring with Background)**
var text_x = ui_x;  // Centered relative to the ring
var text_y = ui_y + ring_radius + 50;  // Just below the ring

// 🔳 **Draw Background Box for Visibility**
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(text_x - 60, text_y - 10, text_x + 70, text_y + 30, false); // Semi-transparent box
draw_set_alpha(1);

// 🔤 **Draw Stirs Text**
draw_set_color(c_white);
draw_text(text_x - 40, text_y, "Stirs: " + string(successful_stirs) + "/" + string(max_stirs));
