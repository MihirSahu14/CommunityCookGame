// Only works in morning prep phase
if (global.game_phase != "morning") exit;

if (distance_to_object(obj_player) < 32 && keyboard_check_pressed(vk_enter)) {
    var player = instance_find(obj_player, 0);

    if (player != noone && array_length(player.inventory) > 0) {
        // Loop to find first mashable item
        for (var i = 0; i < array_length(player.inventory); i++) {
            var item = player.inventory[i];

            if (item.is_mashable) {
                global.minigame_ingredient = item;
                array_delete(player.inventory, i, 1);

                room_goto(rm_mashing_minigame);
                break;
            }
        }
    }
}
