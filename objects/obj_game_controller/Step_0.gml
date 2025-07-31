var player = instance_find(obj_player, 0);

if (player != noone) {
    global.todo_list = [];

    // === SPAWN NPCs ONLY ONCE EACH DAY IN SERVING ROOM ===
     if (room == rm_serving_area && !global.npcs_spawned) {
        // Destroy any leftover NPCs from previous day
        with (obj_npc) instance_destroy();

        var all_npc_objs = [obj_npc_1, obj_npc_2, obj_npc_3, obj_npc_4, obj_npc_5, obj_npc_6, obj_npc_7, obj_npc_8, obj_npc_9];

        // === Define fixed positions for each day ===
        var positions_day_1 = [
            [300, 200], [500, 850], [800, 400], [1000, 700], [1650, 750]
        ];

        var positions_day_2 = [
           [300, 200], [500, 850], [800, 400], [1000, 700], [1650, 750], [280, 550], [1250, 250]
        ];

        var positions_day_3 = [
            [300, 200], [500, 850], [800, 400], [1000, 700], [1650, 750], [280, 550], [1250, 250], [1280, 850], [100, 850]
        ];

        var npcs_to_spawn = 5;
        var positions = positions_day_1;
        if (global.game_day == 2) {
            npcs_to_spawn = 7;
            positions = positions_day_2;
        } else if (global.game_day == 3) {
            npcs_to_spawn = 9;
            positions = positions_day_3;
        }

        for (var i = 0; i < npcs_to_spawn; i++) {
            var npc_obj = all_npc_objs[i];
            var spawn_x = positions[i][0];
            var spawn_y = positions[i][1];

            var inst = instance_create_layer(spawn_x, spawn_y, "Instances", npc_obj);
            inst.npc_id = i + 1; // for internal/debug purposes
        }

        global.npcs_spawned = true;
    }

    // === PHASE: MORNING ===
    if (global.game_phase == "morning") {
        for (var i = 0; i < array_length(player.inventory); i++) {
            var item = player.inventory[i];
            if (item.is_choppable) array_push(global.todo_list, "Cut " + item.name + " (station 2)");
            else if (item.is_mashable) array_push(global.todo_list, "Mash " + item.name + " (station 3)");
            else if (!item.is_spice) array_push(global.todo_list, "Prep " + item.name);
        }

        global.todo_list = array_unique(global.todo_list);

        if (!variable_global_exists("prev_todo_length")) {
            global.prev_todo_length = 999;
        }

        if (global.prev_todo_length > 0 && array_length(global.todo_list) == 0) {
            global.phase_locked = false;
        }

        global.prev_todo_length = array_length(global.todo_list);

        if (array_length(global.todo_list) == 0 && !show_phase_prompt && !global.phase_locked) {
            var prepared_names = [];
            for (var p = 0; p < array_length(player.prepared); p++) {
                array_push(prepared_names, player.prepared[p].name);
            }

            var recipe_ready = false;
            for (var r = 0; r < array_length(global.recipe_list); r++) {
                var recipe = global.recipe_list[r];
                if (array_contains(prepared_names, recipe.ingredients[0]) &&
                    array_contains(prepared_names, recipe.ingredients[1])) {
                    recipe_ready = true;
                    break;
                }
            }

            if (recipe_ready) {
                show_phase_prompt = true;
            }
        }
    }

    // === PHASE: COOKING ===
    else if (global.game_phase == "cooking") {
        if (array_length(player.prepared) > 0) {
            array_push(global.todo_list, "Cook Dish");
        }

        if (room == rm_kitchen) {
            var pot = instance_find(obj_stove_pot, 0);
            if (pot != noone) {
                global.cooking_in_progress = pot.cooking_started;
            }
        }

        var pot_busy = global.cooking_in_progress;

        if (array_length(player.prepared) == 0 && !pot_busy && !global.phase_locked && !show_phase_prompt) {
            show_debug_message("✅ All dishes cooked. Prompting phase change.");
            show_phase_prompt = true;
        }
    }

    // === PHASE: SERVING ===
    else if (global.game_phase == "serving") {
        array_push(global.todo_list, "Serve the Dishes");

        var total_npcs = 0;
        var served_count = 0;

        var all_npcs = [obj_npc_1, obj_npc_2, obj_npc_3, obj_npc_4, obj_npc_5, obj_npc_6, obj_npc_7, obj_npc_8, obj_npc_9];
        for (var i = 0; i < array_length(all_npcs); i++) {
            var npc_obj = all_npcs[i];
            with (npc_obj) {
                total_npcs++;
                if (has_been_served) served_count++;
            }
        }

        if (total_npcs > 0 && served_count == total_npcs && !global.result_prompt_shown) {
            global.result_prompt_shown = true;
            global.time_label = "19:00 Night";
            show_result_popup = true;
        }
    }
}

// === Restart Button Logic ===
var btn_w = 120;
var btn_h = 40;
var btn_x = display_get_gui_width() - btn_w - 30;
var btn_y = display_get_gui_height() - btn_h - 30;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mx, my, btn_x, btn_y, btn_x + btn_w, btn_y + btn_h)) {
        // Reset Day
        global.phase_locked = false;
        global.result_prompt_shown = false;
        global.cooked_dishes = [];
        global.npcs_spawned = false;
        global.current_talking_npc = noone;
        global.community_reqs = [];
        global.npc_reactions = { Good: 0, Neutral: 0, Bad: 0 };
        global.todo_list = [];
        global.game_phase = "morning";
        global.time_label = "9:00 Morning";

        var player = instance_find(obj_player, 0);
        if (player != noone) {
            player.prepared = [];
            player.inventory = [];
            player.x = room_width / 2;
            player.y = room_height / 2;
        }

        room_goto(rm_kitchen);
    }
}

