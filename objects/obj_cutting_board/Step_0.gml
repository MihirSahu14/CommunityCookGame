if (global.game_phase != "morning") exit;
// Interact if player is close and presses Enter
if (distance_to_object(obj_player) < 32 && keyboard_check_pressed(vk_enter)) {
    var player = instance_find(obj_player, 0);

    if (player != noone && array_length(player.inventory) > 0) {
        // Loop through inventory and find the first choppable item
        for (var i = 0; i < array_length(player.inventory); i++) {
            var item = player.inventory[i];

            if (item.is_choppable) {
                // Pass ingredient to global variable
                global.minigame_ingredient = {
                    name: item.name,
                    qty: item.qty,
                    fullness: item.fullness,
                    vitamins: item.vitamins,
                    protein: item.protein,
                    salt: item.salt,
                    is_spice: item.is_spice,
                    is_choppable: item.is_choppable,
                    is_mashable: item.is_mashable
                };

                // Remove from inventory
                array_delete(player.inventory, i, 1);

                // Go to the chopping minigame
                room_goto(rm_chopping_minigame);
                break;
            }
        }
    }
}

