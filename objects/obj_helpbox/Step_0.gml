if (showing_helpbox) {
    if (keyboard_check_pressed(vk_right)) {
        if (current_page < array_length(help_pages)) {
            current_page++;
        }
    }

    if (keyboard_check_pressed(vk_left)) {
        if (current_page > 0) {
            current_page--;
        }
    }
}
