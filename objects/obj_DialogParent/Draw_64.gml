if (showing_dialog) {
    // Get the GUI dimensions
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    
    // Set the box to be 1/4 of the screen height and position it at the bottom
    var box_height = gui_h / 4;
    var box_y = gui_h - box_height;
    
    // --- Draw the Text Box Background ---
    draw_set_color(c_black);
    draw_rectangle(0, box_y, gui_w, gui_h, false);
    
    // --- Draw the White Border (Top, Bottom, Left, Right) ---
    draw_set_color(c_white);
    // Top border
    draw_line(0, box_y, gui_w, box_y);
    // Bottom border
    draw_line(0, gui_h - 1, gui_w, gui_h - 1);
    // Left border
    draw_line(0, box_y, 0, gui_h);
    // Right border
    draw_line(gui_w - 1, box_y, gui_w - 1, gui_h);
    
    // --- Draw the Text ---
    var text_x = 32;
    var text_y = box_y + 32;
    var text_scale = 1.8;

    draw_set_color(c_white);

    // Get the current block of 4 lines
    var block = dialog_blocks[dialog_index];
    
    // Loop through and draw the lines in the block (4 lines per block)
    for (var i = 0; i < array_length(block); i++) {
        draw_text_transformed(text_x, text_y, block[i], text_scale, text_scale, 0);
        text_y += 32; // Move down for the next line
    }
} else if (dialog_done && keyboard_check_pressed(vk_enter)) {
    if (object_index == obj_DialogChild2) {
        if (global.game_day == 3) {
            global.final_results = global.npc_reactions;
            instance_create_layer(0, 0, "Instances", obj_DialogFinal);
            instance_destroy(); // Remove results dialog
        } else {
            global.game_day += 1;
            global.npcs_spawned = false;
            global.result_prompt_shown = false;
            global.npc_reactions = { Good: 0, Neutral: 0, Bad: 0 };
            global.cooked_dishes = [];
			global.community_reqs = [];
            global.game_phase = "morning";
            global.time_label = "9:00 Morning";

            var player = instance_find(obj_player, 0);
            if (player != noone) {
                player.x = room_width / 2;
                player.y = room_height / 2;
            }
            room_goto(rm_kitchen);
        }
    } else if (object_index == obj_DialogFinal) {
        room_goto(rm_titlescreen); // End the game after the final summary
    } else {
        room_goto_next();
    }
}
