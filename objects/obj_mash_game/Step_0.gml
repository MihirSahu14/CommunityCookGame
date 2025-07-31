// Charging
if (keyboard_check(vk_space)) {
    charging = true;
    released = false;
    charge += 8;
    charge = clamp(charge, 0, bar_w);
}

// On release
if (charging && !keyboard_check(vk_space) && !released) {
    charging = false;
    released = true;

    var charge_x = bar_x + charge;

    if (charge_x >= target_zone_start && charge_x <= target_zone_start + target_zone_width) {
        successful_hits += 1;
        show_debug_message("✅ Successful mash!");
    } else {
        show_debug_message("❌ Missed!");
    }

    // Reset
    charge = 0;
    target_zone_start = irandom_range(bar_x + 50, bar_end - target_zone_width - 50);
}

// Win condition
if (successful_hits >= max_hits) {
    var task_name = "Mash " + global.minigame_ingredient.name;
    scr_mark_task_done(task_name);

    with (obj_player) {
        if (!variable_instance_exists(id, "prepared")) {
            prepared = [];
        }
        array_push(prepared, global.minigame_ingredient);
    }

    global.minigame_ingredient = undefined;
    room_goto(rm_kitchen);
}
