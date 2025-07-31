if (global.game_phase == "cooking") {

    // === Add Ingredient (only if not overheated) ===
    if (keyboard_check_pressed(vk_enter)&& distance_to_object(obj_player) < 32) {
        with (obj_player) {
            if (array_length(prepared) > 0) {
                var ing = prepared[0];

                // Count non-spices
                var count = 0;
                for (var j = 0; j < array_length(other.contents); j++) {
                    if (!other.contents[j].is_spice) count++;
                }

                if (ing.is_spice || count < 2) {
                    array_delete(prepared, 0, 1);
                    array_push(other.contents, ing);
                    show_debug_message("➕ Added " + ing.name);
                } else {
                    show_debug_message("🚫 Max ingredients in pot.");
                }
            }
        }
    }

    // === Count non-spice ingredients to start cooking
    var non_spice_ingredients = [];
    for (var i = 0; i < array_length(contents); i++) {
        if (!contents[i].is_spice) array_push(non_spice_ingredients, contents[i]);
    }

    if (array_length(non_spice_ingredients) == 2 && !cooking_started) {
        cooking_started = true;
        show_debug_message("🔥 Cooking started!");
    }

    // === Cooking logic
    if (cooking_started) {
        frame_timer += 1;
        if (frame_timer >= 30) {
            cooking_progress += 1;
            heat += irandom_range(1, 3);
            global.time_remaining -= 1;
            frame_timer = 0;
        }

        if (cooking_progress >= 100) {
            cooked = true;

            // Match recipe
            var ingr1 = non_spice_ingredients[0];
            var ingr2 = non_spice_ingredients[1];

            var qty1 = ingr1.qty;
            var qty2 = ingr2.qty;

            var dish_qty = min(qty1, qty2);
            var dish_name = "Unknown Dish";

            // Look for the recipe from the recipe list
            for (var r = 0; r < array_length(global.recipe_list); r++) {
                var rec = global.recipe_list[r];
                if ((rec.ingredients[0] == ingr1.name && rec.ingredients[1] == ingr2.name) ||
                    (rec.ingredients[1] == ingr1.name && rec.ingredients[0] == ingr2.name)) {
                    dish_name = rec.result;
                    break;
                }
            }

            // Check if global cooked dishes exist, create if they don't
            if (!variable_global_exists("cooked_dishes")) {
                global.cooked_dishes = [];
            }

            // Create a dish summary with name, quantity, ingredients, and burnt status
            var dish_summary = {
                name: dish_name,
                qty: dish_qty,
                ingredients: contents,
                burnt: (heat > 100),
				nutrients: {
			        fullness: ingr1.fullness + ingr2.fullness,
			        vitamins: ingr1.vitamins + ingr2.vitamins,
			        protein: ingr1.protein + ingr2.protein,
			        salt: ingr1.salt + ingr2.salt
			    }
            };

			if (dish_summary.burnt) {
			    dish_summary.nutrients.fullness = ceil(dish_summary.nutrients.fullness / 2);
			    dish_summary.nutrients.vitamins = ceil(dish_summary.nutrients.vitamins / 2);
			    dish_summary.nutrients.protein = ceil(dish_summary.nutrients.protein / 2);
			    dish_summary.nutrients.salt = ceil(dish_summary.nutrients.salt / 2);
			}

			            // Add the dish summary to the global list of cooked dishes
            array_push(global.cooked_dishes, dish_summary);

            // ✅ Display result
            if (dish_summary.burnt) {
                show_debug_message("⚠️ Cooked " + dish_name + " x" + string(dish_qty) + " but burnt!");
            } else {
                show_debug_message("✅ Cooked " + dish_name + " x" + string(dish_qty));
            }

            // 🔁 Reset for next dish
            contents = [];
            cooking_progress = 0;
            heat = 0;
            overheated = false;
            cooking_started = false;
			global.cooking_in_progress = false;

        }
    }

    // === Overheat check
    if (!overheated && heat > 100) {
        overheated = true;
        show_debug_message("🔥 Pot overheated!");
    }

    // === Enter cooling minigame
    if (overheated) {
        if (distance_to_object(obj_player) < 32 && keyboard_check_pressed(vk_enter)) {
            global.return_room = room;
            room_goto(rm_cooking_minigame);
        }
    }
}

// === Persist global state
global.cooking_progress = cooking_progress;
global.heat = heat;
global.overheated = overheated;
global.cooked = cooked;
global.pot_contents = contents;
global.cooking_started = cooking_started;
global.frame_timer = frame_timer;
