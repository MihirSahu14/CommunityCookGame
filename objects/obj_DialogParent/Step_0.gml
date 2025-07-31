// Check for key press to advance text
if (keyboard_check_pressed(vk_enter)) {
    dialog_index++; // Move to the next block

    // If we've passed the last block, mark dialogue as done
    if (dialog_index >= array_length(dialog_blocks)) {
        dialog_done = true;
        showing_dialog = false; // Set this to false to stop showing the dialog box
    }
}
