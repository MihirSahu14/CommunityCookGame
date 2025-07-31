if (global.game_phase == "cooking") {
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(40, 30, 550, 500, false);
    draw_set_alpha(1);

    draw_set_color(c_white);
    draw_text(60, 50, "Cooking Progress: " + string(floor(cooking_progress)) + " / 100");
    draw_text(60, 80, "Heat Level: " + string(floor(heat)));
    draw_text(60, 110, "Ingredients in Pot:");

    var y_pos = 140;
    for (var i = 0; i < array_length(contents); i++) {
        draw_text(70, y_pos, "- " + contents[i].name);
        y_pos += 20;
    }

    // === Show last dish status
	if (cooked && array_length(global.cooked_dishes) > 0) {
	    var last_dish = global.cooked_dishes[array_length(global.cooked_dishes) - 1];
	    var label = last_dish.name + " x" + string(last_dish.qty) + (last_dish.burnt ? " (Burnt)" : "");
	    draw_text(260, 250, "✅ Cooked: " + label);
	}

	// === Show overheating status independently
	if (overheated) {
	    draw_text(260, 280, "🔥 POT OVERHEATED!");
	}

    // === Show cooked dish history
    if (variable_global_exists("cooked_dishes")) {
        draw_text(60, 320, "Cooked Dishes:");
        var y2 = 350;
        for (var i = 0; i < array_length(global.cooked_dishes); i++) {
            var d = global.cooked_dishes[i];
            var label = d.name + " x" + string(d.qty) + (d.burnt ? " (Burnt)" : "") + " F:" + string(d.nutrients.fullness)+ " V:" + string(d.nutrients.vitamins)+ " P:" + string(d.nutrients.protein)+ " S:" + string(d.nutrients.salt);
            draw_text(70, y2, "- " + label);
            y2 += 20;
        }
    }
}