draw_self(); // Draw background sprite (if any)

// Use default font, scale it up
draw_set_font(-1);
draw_set_color(c_white);
draw_set_alpha(alpha);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Camera setup
var cam = view_camera[0];

// Manually place the text a bit to the right and lower
// You said 1920x1080 — we'll position it around (1040, 990)
var xPos = camera_get_view_x(cam) + 1000;
var yPos = camera_get_view_y(cam) + 950;

// Draw the text larger (2.5x)
draw_text_transformed(xPos, yPos, message, 2.5, 2.5, 0);

// Reset alpha
draw_set_alpha(1);
