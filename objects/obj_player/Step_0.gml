// === Hide in minigame rooms ===
visible = string_pos("minigame", room_get_name(room)) == 0;

if (room != rm_serving_area && variable_global_exists("current_talking_npc")) {
    global.current_talking_npc = noone;
}
// === Disable movement if Pantry UI is open ===
if (instance_exists(obj_pantry) && obj_pantry.show_ui) exit;

// === Room Transition Cooldown ===
if (!variable_global_exists("room_transition_cooldown")) global.room_transition_cooldown = 0;
if (global.room_transition_cooldown > 0) global.room_transition_cooldown -= 1;

// === Movement Reset ===
xspd = 0;
yspd = 0;

// === Hitbox Settings ===
hitbox_w = 16;
hitbox_h = 24;
hitbox_offset_x = -8;
hitbox_offset_y = -12;

// === Movement & Collision Check ===
if (keyboard_check(ord("D")) || keyboard_check(vk_right)) {
    if (!collision_rectangle(x + hitbox_offset_x + move_spd, y + hitbox_offset_y, 
                             x + hitbox_offset_x + hitbox_w + move_spd, y + hitbox_offset_y + hitbox_h,
                             obj_solid_parent, false, true)) {
        xspd = move_spd;
        facing = 3;
    }
}
if (keyboard_check(ord("A")) || keyboard_check(vk_left)) {
    if (!collision_rectangle(x + hitbox_offset_x - move_spd, y + hitbox_offset_y, 
                             x + hitbox_offset_x + hitbox_w - move_spd, y + hitbox_offset_y + hitbox_h,
                             obj_solid_parent, false, true)) {
        xspd = -move_spd;
        facing = 2;
    }
}
if (keyboard_check(ord("W")) || keyboard_check(vk_up)) {
    if (!collision_rectangle(x + hitbox_offset_x, y + hitbox_offset_y - move_spd, 
                             x + hitbox_offset_x + hitbox_w, y + hitbox_offset_y + hitbox_h - move_spd,
                             obj_solid_parent, false, true)) {
        yspd = -move_spd;
        facing = 1;
    }
}
if (keyboard_check(ord("S")) || keyboard_check(vk_down)) {
    if (!collision_rectangle(x + hitbox_offset_x, y + hitbox_offset_y + move_spd, 
                             x + hitbox_offset_x + hitbox_w, y + hitbox_offset_y + hitbox_h + move_spd,
                             obj_solid_parent, false, true)) {
        yspd = move_spd;
        facing = 0;
    }
}

// === Apply Movement ===
x += xspd;
y += yspd;

// === Animation ===
if (xspd != 0 || yspd != 0) {
    sprite_index = spr_walk[facing];
    image_speed = 0.2;
} else {
    sprite_index = spr_idle[facing];
    image_index = 0;
}

if (global.game_phase == "cooking" && array_length(global.cooked_dishes) > 0) {
    // Directly refer to global.cooked_dishes to avoid duplication
    cooked_dishes = global.cooked_dishes;
}

// === Handle Room Transitions ===

// KITCHEN → SERVING
if (room == rm_kitchen && y > room_height && global.room_transition_cooldown == 0) {
    global.from_kitchen = true;
    global.room_transition_cooldown = 15;
    room_goto(rm_serving_area);
}

// SERVING → KITCHEN (top middle)
if (room == rm_serving_area && global.room_transition_cooldown == 0) {
    var mid_x = room_width / 2;
    var range = 64;

    if (y < 0 && abs(x - mid_x) < range) {
        global.from_serving_area = true;
        global.room_transition_cooldown = 15;
        room_goto(rm_kitchen);
    }
}

// === Entry Positioning After Transition ===
if (variable_global_exists("from_kitchen") && global.from_kitchen) {
    if (room == rm_serving_area) {
        x = room_width / 2;
        y = 10;
        global.from_kitchen = false;
    }
}
if (variable_global_exists("from_serving_area") && global.from_serving_area) {
    if (room == rm_kitchen) {
        x = room_width / 2;
        y = room_height - 10;
        global.from_serving_area = false;
    }
}

if (room != rm_serving_area) {
    if (variable_global_exists("npcs_spawned")) {
        global.npcs_spawned = false;
    }
}

