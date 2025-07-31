if (show_recipebook) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    var box_w = 800;
    var box_h = 850;
    var box_x = (gui_w - box_w) / 2;
    var box_y = (gui_h - box_h) / 2 - 50;

    // Background
    draw_set_alpha(0.85);
    draw_set_color(c_black);
    draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);
    draw_set_alpha(1);

    // Border
    draw_set_color(c_white);
    draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, true);

    // Title
    draw_set_font(-1);
    draw_set_color(c_white);
    draw_text(box_x + 10, box_y + 10, "Recipe Book");

    var y_pos = box_y + 40;
    var line_height = 28;

    // Pantry for nutrition lookup (same order used in game)
    var pantry = [
        {name:"Potatoes", fullness:5, vitamins:3, protein:1, salt:0},
        {name:"Canned Meat", fullness:2, vitamins:0, protein:4, salt:3},
        {name:"Rice", fullness:3, vitamins:3, protein:0, salt:3},
        {name:"Carrot", fullness:3, vitamins:4, protein:0, salt:2},
        {name:"Dried Bean", fullness:3, vitamins:2, protein:4, salt:0},
        {name:"Cabbage", fullness:2, vitamins:5, protein:1, salt:1}
    ];

    // Recipes (ingredient A, B, result)
    var raw_recipes = [
        ["Potatoes", "Potatoes", "Potato soup"],
        ["Potatoes", "Canned Meat", "Meat potato hash"],
        ["Potatoes", "Rice", "Aloo rice"],
        ["Potatoes", "Carrot", "Mix soup"],
        ["Potatoes", "Dried Bean", "Jacket potatoes"],
        ["Potatoes", "Cabbage", "Colcannon"],
        ["Canned Meat", "Canned Meat", "Meat loaf"],
        ["Canned Meat", "Rice", "Beef bowl"],
        ["Canned Meat", "Carrot", "Mix stew"],
        ["Canned Meat", "Dried Bean", "Chili"],
        ["Canned Meat", "Cabbage", "Cabbage roll"],
        ["Rice", "Rice", "Cooked rice"],
        ["Rice", "Carrot", "Fried rice"],
        ["Rice", "Dried Bean", "Mix bowl"],
        ["Rice", "Cabbage", "Mix soup"],
        ["Carrot", "Carrot", "Carrot stew"],
        ["Carrot", "Dried Bean", "Vegan patties"],
        ["Carrot", "Cabbage", "Cabbage-Carrot Casserole"],
        ["Dried Bean", "Dried Bean", "Lentil soup"],
        ["Dried Bean", "Cabbage", "Mix soup"],
        ["Cabbage", "Cabbage", "Cabbage soup"]
    ];

    var seen = [];

    for (var i = 0; i < array_length(raw_recipes); i++) {
        var a = raw_recipes[i][0];
        var b = raw_recipes[i][1];
        var result = raw_recipes[i][2];

        var key = (a < b) ? a + "+" + b : b + "+" + a;

        if (!array_contains(seen, key)) {
            array_push(seen, key);

            // Nutrition sum
            var nut1 = undefined;
            var nut2 = undefined;
            for (var j = 0; j < array_length(pantry); j++) {
                if (pantry[j].name == a) nut1 = pantry[j];
                if (pantry[j].name == b) nut2 = pantry[j];
            }

            var f = nut1.fullness + nut2.fullness;
            var v = nut1.vitamins + nut2.vitamins;
            var p = nut1.protein + nut2.protein;
            var s = nut1.salt + nut2.salt;

            var line = "Ingredients: " + a + ", " + b + " -> " + result;
            line += "   (F:" + string(f) + " V:" + string(v) + " P:" + string(p) + " S:" + string(s) + ")";
            draw_text(box_x + 10, y_pos, line);
            y_pos += line_height;
        }
    }

    draw_text(box_x + 10, y_pos + 20, "[Click the Recipe Book Again to Close].");
}
