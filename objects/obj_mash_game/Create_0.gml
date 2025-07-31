// Get screen dimensions (1920x1080 safe)
var screen_width = display_get_width();

// Charge bar position and size (centered)
bar_x = screen_width / 2 - 800 + 50;
bar_w = 900;
bar_y = 170;
bar_h = 20;
bar_end = bar_x + bar_w;

// Setup charge
charge = 0;
charging = false;
released = false;

// Target zone (fully inside charge bar)
target_zone_width = 150;
target_zone_start = irandom_range(bar_x + 50, bar_end - target_zone_width - 50);

// Progress tracking
successful_hits = 0;
max_hits = 5;
