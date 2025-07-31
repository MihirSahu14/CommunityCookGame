// Get Screen Dimensions (1920x1080)
var screen_width = display_get_width();
var screen_height = display_get_height();

// 🔵 **UI Position (Top Blue Section)**
var ui_x = screen_width / 2 - 800; // Centered horizontally
var ui_y = 50; // Positioned in the blue area
var box_width = 1000; // Wider UI
var box_height = 200; // Taller UI

// 🔵 **Draw Background Box (UI Container)**
draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(ui_x - 20, ui_y - 20, ui_x + box_width, ui_y + box_height, false);
draw_set_alpha(1);

// 🔵 **Display Instructions (Larger & Centered)**
draw_set_color(c_white);
draw_text(ui_x + 50, ui_y + 20, "Press ENTER to cut at the right moment!");
draw_text(ui_x + 50, ui_y + 60, "Successful Slices: " + string(successful_slices) + "/" + string(max_slices));

// 🔴 **Fixing the Chopping Bar Position (Relative to UI)**
var bar_x_start = ui_x + 50; // Align to UI
var bar_x_end = ui_x + box_width - 50; // Keep within UI
var bar_y = ui_y + 120; // Place inside the UI box

// 🔴 **Draw Cutting Area (Static Guide)**
draw_set_color(c_white);
draw_rectangle(bar_x_start, bar_y, bar_x_end, bar_y + 20, false); // Static chopping area

// 🟢 **Draw Target Cut Line (Now Shrinks Over Time)**
draw_set_color(c_green);
draw_rectangle(slice_target - (target_size / 2), bar_y, slice_target + (target_size / 2), bar_y + 20, false);

// 🔴 **Draw Moving Bar (Now fully inside)**
draw_set_color(c_red);
draw_rectangle(bar_x_start + slice_progress, bar_y, bar_x_start + slice_progress + slice_size, bar_y + 20, false);

