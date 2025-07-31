// Player Initialization
hitbox_w = 16; // width of your collision box
hitbox_h = 24; // height of your collision box
hitbox_offset_x = -8; // shift left/right (adjust based on origin)
hitbox_offset_y = -12; // shift up/down

// Movement Variables
move_spd = 4;
xspd = 0;
yspd = 0;

// Assign Sprites for Directions
spr_idle[0] = spr_player_idle_down;
spr_idle[1] = spr_player_idle_up;
spr_idle[2] = spr_player_idle_left;
spr_idle[3] = spr_player_idle_right;

spr_walk[0] = spr_player_walk_down;
spr_walk[1] = spr_player_walk_up;
spr_walk[2] = spr_player_walk_left;
spr_walk[3] = spr_player_walk_right;

// Default Direction (Down)
facing = 0;
inventory = [];
prepared = []; // Optional, if not already initialized
cooked_dishes = []; // Initialize empty cooked_dishes array
persistent = true;

// === Ensure global.cooked_dishes exists before referencing it ===
if (!variable_global_exists("cooked_dishes")) {
    global.cooked_dishes = []; // Initialize cooked_dishes if it doesn't exist
}

// Reference global.cooked_dishes
cooked_dishes = global.cooked_dishes;  // Reference, do not copy

if (!variable_global_exists("community_reqs")) {
    global.community_reqs = [];
}

