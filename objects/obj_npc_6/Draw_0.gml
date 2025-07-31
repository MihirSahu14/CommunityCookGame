draw_self();

var gui_w = display_get_gui_width();
var margin = 10;

// === Show Intro Dialogue with BG ===
if (show_intro) {
    var stats = 
        " (F:" + string(nutrient_pref.fullness) + 
        " V:" + string(nutrient_pref.vitamins) + 
        " P:" + string(nutrient_pref.protein) + 
        " S:" + string(nutrient_pref.salt) + ")";
        
    var full_text = dialogue + stats;
    var text_width = string_width(full_text);
    var text_height = string_height(full_text);
    
    var text_x = clamp(x - text_width / 2, margin, gui_w - text_width - margin);
    var text_y = y - 70;

    // Draw background box
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(text_x - 10, text_y - 10, text_x + text_width + 10, text_y + text_height + 10, false);
    draw_set_alpha(1);

    // Draw text
    draw_set_color(c_white);
    draw_text(text_x, text_y, full_text);
}

// === Show Reaction with BG ===
if (has_been_served && !ui_open && !show_intro) {
    var text_reaction = reaction;
    var text_served = "✅ Served";

    var width = max(string_width(text_reaction), string_width(text_served));
    var text_x = clamp(x - width / 2, margin, gui_w - width - margin);
    var text_y = y - 70;

    // Draw background box
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(text_x - 10, text_y - 10, text_x + width + 10, text_y + 45, false);
    draw_set_alpha(1);

    // Draw texts
    draw_set_color(c_white);
    draw_text(text_x, text_y, text_reaction);
    draw_text(text_x, text_y + 25, text_served);
}

// === Dish Selection UI ===
if (ui_open) {
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(100, 100, 700, 400, false);
    draw_set_alpha(1);

    draw_set_color(c_white);

    // === Display NPC Name & Nutrient Needs at the top ===
    var header_y = 110;
    draw_text(120, header_y, "Serving: " + name);
    draw_text(120, header_y + 25, "Needs - F:" + string(nutrient_pref.fullness) + 
                                 " V:" + string(nutrient_pref.vitamins) + 
                                 " P:" + string(nutrient_pref.protein) + 
                                 " S:" + string(nutrient_pref.salt));

    // === Dish list ===
    draw_text(120, 160, "Choose a dish to serve:");

    for (var i = 0; i < array_length(global.cooked_dishes); i++) {
        var dish = global.cooked_dishes[i];
        var nutrients = dish.nutrients;

        var label = string(i + 1) + ". " + dish.name + " x" + string(dish.qty);
        label += " | F:" + string(nutrients.fullness) +
                 " V:" + string(nutrients.vitamins) +
                 " P:" + string(nutrients.protein) +
                 " S:" + string(nutrients.salt);

        draw_text(140, 190 + i * 30, label);
    }

    draw_text(120, 190 + array_length(global.cooked_dishes) * 30 + 20, 
              "Press 1 to 9 to serve, or ESC to cancel.");
}
