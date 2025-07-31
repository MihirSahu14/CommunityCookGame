draw_self();

if (!has_been_served) {
	draw_set_color(c_black);
    draw_set_alpha(0.7); // Make it slightly transparent
    draw_rectangle(x - 40, y - 55, x + 120, y - 20, false); // Box around text
    draw_set_alpha(1); // Reset alpha
    draw_set_color(c_white);
    draw_text(x - 30, y - 40, 
        "F:" + string(nutrient_pref.fullness) +
        " V:" + string(nutrient_pref.vitamins) +
        " P:" + string(nutrient_pref.protein) +
        " S:" + string(nutrient_pref.salt));
} else {
	draw_set_color(c_black);
    draw_set_alpha(0.7); // Make it slightly transparent
    draw_rectangle(x - 45, y - 70, x + 120, y - 20, false); // Box around text
    draw_set_alpha(1); // Reset alpha
    draw_set_color(c_white);
    draw_text(x - 30, y - 40, "✅ Served");
    draw_text(x - 30, y - 60, "Reaction: " + reaction);  // Show NPC's reaction
}

// UI popup for choosing dish
if (ui_open) {
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(100, 100, 700, 400, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(120, 120, "Choose a dish to serve:");

    for (var i = 0; i < array_length(global.cooked_dishes); i++) {
        var dish = global.cooked_dishes[i];
        var name = dish.name;
        var nutrients = (is_struct(dish.nutrients)) ? dish.nutrients : {
		    fullness: 0,
		    vitamins: 0,
		    protein: 0,
		    salt: 0
		};

		var text = string(i + 1) + ". " + name + 
		    " | F:" + string(nutrients.fullness) + 
		    " V:" + string(nutrients.vitamins) +
		    " P:" + string(nutrients.protein) + 
		    " S:" + string(nutrients.salt);


        draw_text(140, 150 + i * 30, text);
    }

    draw_text(120, 150 + array_length(global.cooked_dishes) * 30 + 20, 
              "Press 1 to 9 to serve, or ESC to cancel.");
}
