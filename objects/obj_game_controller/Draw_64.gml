if (!variable_global_exists("todo_list")) exit;

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

var box_margin = 30;
var box_x = gui_width - 300;
var box_y = box_margin;
var box_w = 250;
var box_h = 100 + array_length(global.todo_list) * 25;

// === Background Box ===
draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(box_x - 10, box_y - 10, box_x + box_w, box_y + box_h, false);
draw_set_alpha(1);

// === Header ===
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_text(box_x, box_y, "DAY " + string(global.game_day));
draw_text(box_x, box_y + 20, global.time_label);
draw_text(box_x, box_y + 50, "TO DO:");

// === Task List ===
var y_offset = box_y + 75;
for (var i = 0; i < array_length(global.todo_list); i++) {
    draw_text(box_x, y_offset, "❌ " + global.todo_list[i]);
    y_offset += 25;
}

// === Restart Button ===
var btn_w = 120;
var btn_h = 40;
var btn_x = display_get_gui_width() - btn_w - 30; // 30px margin from right
var btn_y = display_get_gui_height() - btn_h - 30; // 30px margin from bottom

draw_set_color(c_white);
draw_set_alpha(0.85);
draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);
draw_set_alpha(1);

var hover_restart = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), btn_x, btn_y, btn_x + btn_w, btn_y + btn_h);
draw_set_color(hover_restart ? c_red : c_white);
draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, true);

draw_set_color(c_black);
draw_text(btn_x + 20, btn_y + 10, "Restart");

// === Phase Change Prompt ===
if (show_phase_prompt) {
    var popup_x1 = 600, popup_y1 = 300;
    var popup_x2 = 1000, popup_y2 = 420;

    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(popup_x1, popup_y1, popup_x2, popup_y2, false);
    draw_set_alpha(1);

    draw_set_color(c_white);
    draw_text(popup_x1 + 20, popup_y1 + 20, "All tasks are done! Move to next phase...");

    var btn_x = popup_x1 + 40, btn_y = popup_y1 + 60, btn_w = 120, btn_h = 40;
    button_yes_hovered = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), btn_x, btn_y, btn_x + btn_w, btn_y + btn_h);

    draw_set_color(button_yes_hovered ? c_lime : c_white);
    draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);
    draw_set_color(c_black);
    draw_text(btn_x + 25, btn_y + 10, "OKAY");

    if (mouse_check_button_pressed(mb_left)) {
        if (button_yes_hovered) {
            if (global.game_phase == "morning") {
                global.game_phase = "cooking";
                global.time_label = "12:00 Afternoon";
            } else if (global.game_phase == "cooking") {
                global.game_phase = "serving";
                global.time_label = "16:00 Evening";
            }

            global.phase_locked = false;
            show_phase_prompt = false;
        }
    }
}

if (show_result_popup) {
    var popup_x1 = 600, popup_y1 = 300;
    var popup_x2 = 1000, popup_y2 = 450;

    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(popup_x1, popup_y1, popup_x2, popup_y2, false);
    draw_set_alpha(1);

    draw_set_color(c_white);
    draw_text(popup_x1 + 20, popup_y1 + 20, "All NPCs have been served!");
    draw_text(popup_x1 + 20, popup_y1 + 60, "See your performance summary...");

    var btn_x = popup_x1 + 40, btn_y = popup_y1 + 100, btn_w = 120, btn_h = 40;
    var btn_hover = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), btn_x, btn_y, btn_x + btn_w, btn_y + btn_h);

    draw_set_color(btn_hover ? c_lime : c_white);
    draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);
    draw_set_color(c_black);
    draw_text(btn_x + 25, btn_y + 10, "OKAY");

    if (mouse_check_button_pressed(mb_left) && btn_hover) {
        room_goto(rm_results); // You should create this room
    }
}
