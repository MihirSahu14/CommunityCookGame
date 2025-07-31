if (room != rm_serving_area) {
    visible = false;   // You can use this if you want them to be restored later
    // OR use this if you don't want them to stay at all
    // instance_destroy();
} else {
    visible = true;
}


if (!has_been_served && distance_to_object(obj_player) < 32) {
    if (keyboard_check_pressed(vk_enter)) {
        if (array_length(global.cooked_dishes) > 0) {
            ui_open = true;
        } else {
            show_debug_message("🚫 No dishes available.");
        }
    }
}

// Handle selection
if (ui_open) {
    for (var key = ord("1"); key <= ord("9"); key++) {
        if (keyboard_check_pressed(key)) {
            var index = key - ord("1");
            if (index < array_length(global.cooked_dishes)) {
                served_dish = global.cooked_dishes[index];

                // ❗ Only consume ONE portion of the dish
                if (served_dish.qty > 1) {
                    served_dish.qty -= 1;       // Decrement quantity by 1
                } else {
                    // If there's only 1 left, remove the dish entry entirely
                    array_delete(global.cooked_dishes, index, 1);
                }

                // Mark the NPC as served
                has_been_served = true;
                ui_open = false;
                
                // Calculate the nutrient match percentage
                var match_percentage = calculate_match_percentage();

                // Determine the NPC's reaction based on the match percentage
                if (match_percentage < 50) {
                    reaction = "Bad";  // Less than 50% match
                    show_debug_message("❌ NPC is not happy with the dish.");
                } else if (match_percentage < 80) {
                    reaction = "Neutral";  // Between 50% and 80% match
                    show_debug_message("😐 NPC is neutral about the dish.");
                } else {
                    reaction = "Good";  // 80% or more match
                    show_debug_message("✅ NPC is happy with the dish!");
                }
            }
        }
    }

    // Cancel
    if (keyboard_check_pressed(vk_escape)) {
        ui_open = false;
    }
}
