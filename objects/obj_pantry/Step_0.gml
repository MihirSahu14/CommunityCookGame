if (global.game_phase != "morning") exit;

// Prevent crash if pantry isn't initialized yet
if (!variable_global_exists("pantry")) {
    exit;
}

// Toggle pantry UI when player is nearby
if (distance_to_object(obj_player) < interaction_range) {
    if (keyboard_check_pressed(vk_enter)) {
        show_ui = !show_ui;
    }
}

if (show_ui) {
    var pantry_size = array_length(global.pantry);

    // Navigate item list
    if (keyboard_check_pressed(vk_up)) {
        selected_index = max(0, selected_index - 1);
    }
    if (keyboard_check_pressed(vk_down)) {
        selected_index = min(pantry_size - 1, selected_index + 1);
    }

    // Change quantity
    if (keyboard_check_pressed(vk_right)) {
        selected_qty = min(global.pantry[selected_index].available, selected_qty + 1);
    }
    if (keyboard_check_pressed(vk_left)) {
        selected_qty = max(0, selected_qty - 1);
    }

    // Take item when pressing SPACE
    if (keyboard_check_pressed(vk_space) && selected_qty > 0) {
        global.pantry[selected_index].available -= selected_qty;

        var taken_item = global.pantry[selected_index];
        var qty_taken = selected_qty; // ← fix: store selected_qty before 'with'

        with (obj_player) {
            array_push(inventory, {
                name: taken_item.name,
                qty: qty_taken,
                fullness: taken_item.fullness,
                vitamins: taken_item.vitamins,
                protein: taken_item.protein,
                salt: taken_item.salt,
                is_spice: taken_item.is_spice,
				is_choppable: taken_item.is_choppable,
				is_mashable: taken_item.is_mashable
            });
        }

        selected_qty = 0;
        global.time_remaining -= 1;
    }
}
