if (showing_dialog) {
    // Get the GUI dimensions
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    
    // Set the box to be 1/4 of the screen height and position it at the bottom
    var box_height = gui_h / 4 + 24; // Slightly taller
    var box_y = gui_h - box_height;
    
    // --- Draw the Text Box Background ---
    draw_set_color(c_black);
    draw_rectangle(0, box_y, gui_w, gui_h, false);
    
    // --- Draw the White Border ---
    draw_set_color(c_white);
    draw_line(0, box_y, gui_w, box_y);                  // Top
    draw_line(0, gui_h - 1, gui_w, gui_h - 1);          // Bottom
    draw_line(0, box_y, 0, gui_h);                      // Left
    draw_line(gui_w - 1, box_y, gui_w - 1, gui_h);      // Right
    
    // --- Prepare for Drawing Text ---
    var text_scale = 1.8;
    var block = dialog_blocks[dialog_index];
    
    // Find the widest line
    var max_width = 0;
    for (var i = 0; i < array_length(block); i++) {
        var w = string_width(block[i]) * text_scale;
        if (w > max_width) max_width = w;
    }

    // Center the whole block based on the widest line
    var text_x = (gui_w - max_width) / 2;
    var text_y = box_y + 32;

    draw_set_color(c_white);
    draw_set_halign(fa_left); // Keep left alignment

    // Draw each line using the same x
    for (var i = 0; i < array_length(block); i++) {
        draw_text_transformed(text_x, text_y, block[i], text_scale, text_scale, 0);
        text_y += 32 * text_scale;
    }
} else {
    room_goto_next();
}
