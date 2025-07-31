// === Ensure global talking lock exists ===
if (!variable_global_exists("current_talking_npc")) {
    global.current_talking_npc = noone;
}
if (!variable_global_exists("community_reqs")) {
    global.community_reqs = [];
}

// === Reset lock if player walks away from this NPC
if (global.current_talking_npc == id && point_distance(x, y, obj_player.x, obj_player.y) > 40) {
    global.current_talking_npc = noone;
}

// === Interaction (non-serving phase)
if (!has_been_served && global.game_phase != "serving" && distance_to_object(obj_player) < 24 && !ui_open) {
    if (keyboard_check_pressed(vk_enter) && (global.current_talking_npc == noone || global.current_talking_npc == id)) {
        show_intro = true;
        intro_timer = room_speed * 3;
        global.current_talking_npc = id;

        // Log community need
        var already_logged = false;
        for (var i = 0; i < array_length(global.community_reqs); i++) {
            if (global.community_reqs[i].name == name) {
                already_logged = true;
                break;
            }
        }

        if (!already_logged) {
            var info = {
                name: name,
                fullness: nutrient_pref.fullness,
                vitamins: nutrient_pref.vitamins,
                protein: nutrient_pref.protein,
                salt: nutrient_pref.salt
            };
            array_push(global.community_reqs, info);
        }
    }
}

// === Hide dialogue after timer
if (show_intro) {
    intro_timer--;
    if (intro_timer <= 0) {
        show_intro = false;
        if (global.current_talking_npc == id) {
            global.current_talking_npc = noone;
        }
    }
}

// === Serving logic during serving phase
if (!has_been_served && global.game_phase == "serving" && distance_to_object(obj_player) < 24 && !show_intro) {
    if (keyboard_check_pressed(vk_enter) && (global.current_talking_npc == noone || global.current_talking_npc == id)) {
        if (array_length(global.cooked_dishes) > 0) {
            ui_open = true;
            global.current_talking_npc = id;
        } else {
            show_debug_message("🚫 No dishes available.");
        }
    }
}

// === Dish Selection UI
if (ui_open) {
    for (var key = ord("1"); key <= ord("9"); key++) {
        if (keyboard_check_pressed(key)) {
            var index = key - ord("1");

            if (index < array_length(global.cooked_dishes)) {
                served_dish = global.cooked_dishes[index];
                served_dish.qty -= 1;
                if (served_dish.qty <= 0) {
                    array_delete(global.cooked_dishes, index, 1);
                }

                has_been_served = true;
                ui_open = false;
                global.current_talking_npc = noone;

                // Match %
                var n = served_dish.nutrients;
                var m = 0;
                if (abs(n.fullness - nutrient_pref.fullness) <= 2) m++;
                if (abs(n.vitamins - nutrient_pref.vitamins) <= 2) m++;
                if (abs(n.protein - nutrient_pref.protein) <= 2) m++;
                if (abs(n.salt - nutrient_pref.salt) <= 2) m++;

                var percent = (m / 4) * 100;

                if (percent < 50) {
                    reaction = "Ugh... this isn't what I needed.";
                    global.npc_reactions.Bad += 1;
                } else if (percent < 80) {
                    reaction = "Thanks... it's okay, I guess.";
                    global.npc_reactions.Neutral += 1;
                } else {
                    reaction = "This is exactly what I needed! Thank you.";
                    global.npc_reactions.Good += 1;
                }

                show_debug_message("✅ NPC reaction: " + reaction);
            }
        }
    }

    // Cancel with ESC
    if (keyboard_check_pressed(vk_escape)) {
        ui_open = false;
        if (global.current_talking_npc == id) {
            global.current_talking_npc = noone;
        }
    }
}
