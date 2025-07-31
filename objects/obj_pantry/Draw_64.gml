if (show_ui) {
    // Main UI Box
    draw_set_alpha(0.8);
    draw_set_color(c_black);
    draw_rectangle(60, 20, 700, 400, false); // wider box
    draw_set_alpha(1);
    draw_set_color(c_white);
    
    draw_text(80, 40, "== Pantry ==");

    var y_pos = 80;

    // Loop to display items in the pantry
    for (var i = 0; i < array_length(global.pantry); i++) {
        var item = global.pantry[i];
        var prefix = (i == selected_index) ? "> " : "  ";
        draw_text(80, y_pos, prefix + item.name + " (" + string(item.available) + ")");
        draw_text(300, y_pos, "F:" + string(item.fullness) + " V:" + string(item.vitamins) + " P:" + string(item.protein) + " S:" + string(item.salt));
        y_pos += 30;
    }

    draw_text(80, y_pos + 20, "Selected Qty: " + string(selected_qty));
    draw_text(80, y_pos + 50, "Press [SPACE] to take item.");

    // Warning Text Box
    var warning_box_y = y_pos + 80; // Position for the warning box
    
    draw_set_alpha(0.8);
    draw_set_color(c_black);
    draw_rectangle(60, warning_box_y, 700, warning_box_y + 180, false); // Increased height for more space
    draw_set_alpha(1);
    draw_set_color(c_white);

    // Draw warning text
    draw_text(80, warning_box_y + 20, "WARNING: Prep food in the order you take it out of the inventory");
    draw_text(80, warning_box_y + 50, "(or as seen in your inventory; top to bottom) else your food will");
    draw_text(80, warning_box_y + 80, "go bad and the dish will not turn out as expected!");
    
    // Add a space between the warning and the "Press ENTER to close" line
    draw_text(80, warning_box_y + 120, "Press ENTER to close");
}
