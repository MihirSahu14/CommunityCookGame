// Get Screen Dimensions (1920x1080)
var screen_width = display_get_width();
var screen_height = display_get_height();

// UI Box Position (Top Center)
var ui_x = screen_width / 2 - 800;
var ui_y = 50;
var box_width = 1000;
var box_height = 200;

// Draw background
draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(ui_x - 20, ui_y - 20, ui_x + box_width, ui_y + box_height, false);
draw_set_alpha(1);

// Instructions & status
draw_set_color(c_white);
draw_text(ui_x + 50, ui_y + 20, "Hold SPACE to charge. Release inside the green zone!");
draw_text(ui_x + 50, ui_y + 60, "Successful Mashes: " + string(successful_hits) + "/" + string(max_hits));

// Draw bar outline
draw_set_color(c_white);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);

// Draw green target zone
draw_set_color(c_green);
draw_rectangle(target_zone_start, bar_y, target_zone_start + target_zone_width, bar_y + bar_h, false);

// Draw red charge bar
draw_set_color(c_red);
draw_rectangle(bar_x, bar_y, bar_x + charge, bar_y + bar_h, false);
