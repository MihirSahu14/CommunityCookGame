// Slicing Minigame Variables
slice_progress = 0;  // Moving bar position
slice_speed = 7;     // Speed of the slicing bar
slice_size = 20;     // Width of the slicing bar
successful_slices = 0; // Number of good cuts
max_slices = 5; // Total slices required to finish minigame

// Define movement range dynamically
var screen_width = display_get_width();
var ui_x = screen_width / 2 - 800; // Same as UI positioning
var box_width = 1000;

bar_x_start = ui_x + 50; // Start of white bar
bar_x_end = ui_x + box_width - 50; // End of white bar

// Target Cut Properties
target_size = 250; // 🔴 Large initial target (will shrink)
min_target_size = 8; // 🔴 Minimum size target can shrink to

// Ensure the target cut appears fully within the bar (considering width)
slice_target = random_range(bar_x_start + 10, bar_x_end - 10 - target_size);
