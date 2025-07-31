// Move the slicing bar left and right across the full white area
slice_progress += slice_speed;

// Reverse direction if hitting the exact bar boundaries
if (slice_progress + bar_x_start <= bar_x_start || slice_progress + bar_x_start + slice_size >= bar_x_end - 5) {
    slice_speed *= -1;
}

// Check for player input (Press Enter to Cut)
if (keyboard_check_pressed(vk_enter)) {
    var accuracy = abs((bar_x_start + slice_progress) - slice_target);

    if (accuracy < target_size / 2) {
        show_debug_message("Perfect Cut!");
        successful_slices += 1;
        target_size = max(target_size - 50, min_target_size);
    } else {
        show_debug_message("Bad Cut!");
    }

    slice_size = max(slice_size - 3, 5);
    slice_target = random_range(bar_x_start + 10, bar_x_end - 10 - target_size);
}

// ✅ Check if minigame is complete
if (successful_slices >= max_slices) {
    show_debug_message("Chopping Completed!");
    scr_mark_task_done("Cut Carrots");

    // ✅ Make sure the ingredient exists
    if (variable_global_exists("minigame_ingredient")) {
        global.minigame_ingredient.prepped = true;

        var player = instance_find(obj_player, 0);
        if (player != noone) {
            if (!variable_instance_exists(player, "prepared")) {
                player.prepared = [];
            }

            array_push(player.prepared, global.minigame_ingredient);
        }

        global.minigame_ingredient = undefined;
    } else {
        show_debug_message("⚠️ No minigame ingredient found.");
    }

    // ✅ Return to kitchen after prep
    room_goto(rm_kitchen);
}
