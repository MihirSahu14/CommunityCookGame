// Make the text pulse (fade in and out)
alpha += alpha_direction;
if (alpha <= 0.3 || alpha >= 1) {
    alpha_direction *= -1; // Reverse direction when hitting limits
}

// Check for Enter key to go to the next room
if (keyboard_check_pressed(vk_enter)) {
    room_goto(rm_dialog_intro);
}
