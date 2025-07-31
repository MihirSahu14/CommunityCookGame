if (!game_completed) {
    // Rotate the stir indicator
    angle += stir_speed;
    if (angle >= 360) angle -= 360; // Wrap around

    // Check for player input (Press ENTER to Stir)
    if (keyboard_check_pressed(vk_enter)) {
        var accuracy = abs(angle - target_angle);
        
        if (accuracy < success_range) {
            show_debug_message("Perfect Stir!"); 
            successful_stirs += 1;
        } else {
            show_debug_message("Bad Stir!");
        }

        // Reduce success range to make it harder
        success_range = max(success_range - 3, 5);
        
        // Generate a new target angle
        target_angle = irandom_range(30, 330);
    }

    // 🔴 **Directly Transition When Minigame is Completed**
	if (successful_stirs >= max_stirs) {
	    show_debug_message("Cooking Completed!");
	    scr_mark_task_done("Cook in Pot");  // ✅ Mark this task as done
		global.returning_from_minigame = true;
		room_goto(global.return_room);
	    room_goto(rm_kitchen);
	}
}
