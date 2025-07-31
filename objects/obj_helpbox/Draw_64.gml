if (showing_helpbox) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    var box_w = 1100;
    var box_h = 700;

    var box_x = (gui_w - box_w) / 2;
    var box_y = (gui_h - box_h) / 2;

    // Save current draw state
    var old_font = draw_get_font();
    var old_color = draw_get_color();
    var old_alpha = draw_get_alpha();
    var old_halign = draw_get_halign();
    var old_valign = draw_get_valign();

    // Draw background
    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);
    draw_set_alpha(1);

    // Border
    draw_set_color(c_white);
    draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, true);

    // Text formatting
    var margin = 24;
    var text_x = box_x + margin;
    var text_y = box_y + margin;
    var text_w = box_w - margin * 2;

    draw_set_font(-1); // Set your custom font here
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    var message = "";

    switch (current_page) {
        case 0:
		    message =
		    "COMMUNITY COOKING FIELD MANUAL — Pg. 1\n\n" +
		    "You are the chef.\n" +
		    "Not just any cook but the one the survivors count on.\n" +
		    "Every meal you make could be the difference between\n" +
		    "hope and hunger.\n\n" +
		    "Start your shift in the Kitchen.\n" +
		    "Move around using W, A, S, D.\n" +
		    "Press ENTER to interact with people, objects, and stations.\n\n" +
		    "To view recipes, click the book icon in the bottom left.\n" +
		    "To open this help guide, click the 'Help' icon.\n" +
		    "To restart a day, click the [Restart] button in the bottom-right.\n" +
		    "Use it if you mess up—no shame in starting fresh.\n\n" +
		    "This guide won’t teach you to be a good person—\n" +
		    "but it will show you how to cook like one.";
		    break;

        case 1:
		    message =
		    "Pg. 2 — MORNING DUTY: LISTEN & PLAN\n\n" +
		    "Step outside. Meet the survivors.\n" +
		    "They won’t say it outright—but each one has a need.\n\n" +
		    "Fullness (F)\n"+
			"Vitamins (V)\n"+
			"Protein (P)\n"+
			"Salt (S)\n" +
		    "These are survival's currency now.\n\n" +
		    "After talking, return to the Kitchen to choose the ingredients\n" +
			"You decide the order, and you decide how many of each to take\n"+
			"(Potatoes x2, etc).\n\n" +
		    "Each ingredient has its own nutrition stats.\n" +
		    "Every dish = the combined nutrients of two ingredients.\n\n" +
		    "Example:\n" +
		    "Potato x1 (F:4, P:2) + Carrot x1 (F:3, V:2) -> Mix Soup x1 (F:7, P:2, V:2)\n\n" +
		    "Use the Recipe Book (bottom-left in the Kitchen)\n" +
		    "to view all possible combinations.\n" +
		    "Plan ahead. Cook with purpose.\n\n" +
			"NOTE: See how many people need to be feed outside, you will need to prepare that many meals";
		    break;


		case 2:
            message =
            "Pg. 3   PREP STATIONS & INGREDIENT ORDER\n\n" +
            "After planning your meals, head to the Pantry (Station 1).\n" +
            "Choose ingredients for the day. You can pick any quantity:\n" +
            "- Potato x1\n" +
            "- Beans x2\n" +
            "- Carrot x3, etc.\n\n" +
            "The order you select ingredients matters.\n" +
            "You must prepare and cook them in the same sequence.\n\n" +
            "Example:\n" +
            "Picked: Potato x1 -> Carrot x1 -> Beans x2 -> Rice x2\n" +
            "Prep Order: Potato -> Carrot -> Beans -> Rice\n" +
            "Cooking: Dish 1 = Potato x(n) + Carrot x(n)\n" +
            "         Dish 2 = Beans x(n) + Rice x(n)\n\n" +
            "Use correct stations:\n" +
            "Station 2 (Cutting): Carrot, Cabbage\n" +
            "Station 3 (Mashing): Potato, Beans, Rice, Canned Meat\n\n" +
            "Each successful minigame adds to your Prepared list.\n" +
            "You'll cook dishes in the order your ingredients were prepped.";
            break;


        case 3:
            message =
            "Pg. 4   AFTERNOON: HEAT & HOPE\n\n" +
            "When your prep is done, head to the stove.\n" +
            "Only 2 ingredients can be added at a time.\n" +
            "Add them in the order they appear in your Prepared list.\n\n" +
            "Once added, the pot starts cooking automatically.\n" +
            "Heat will rise. If it goes too high, the dish will burn. i.e. nutrition is halved\n" +
            "You can stop this by using the Cooling Minigame in time.\n\n" +
            "Quantity is determined by how much of each you had:\n" +
            "Potato x2 + Carrot x2 = Dish x2\n" +
            "If one ingredient runs low, you make fewer portions.\n\n" +
            "After each dish is done, it's added to your Cooked Dishes.\n" +
            "Finish all dishes before moving to the next phase.";
            break;

        case 4:
            message =
            "Pg. 5   EVENING: SERVE WITH PURPOSE\n\n" +
            "Return to the community. They've waited all day.\n" +
            "One dish per person. No second chances.\n\n" +
            "Press ENTER to approach."+
            "They'll respond based on how well you fed them.\n\n" +
            "At day’s end, your results show. Their voices echo in your report.\n" +
            "Do better. Or hold onto the good. Tomorrow’s coming fast.";
            break;
    }

    // Page nav
    message += "\n\n[Use <- and -> to turn pages]   [Click 'Help' again to close]";

    draw_text_ext(text_x, text_y, message, -1, text_w);

    // Restore previous draw state
    draw_set_font(old_font);
    draw_set_color(old_color);
    draw_set_alpha(old_alpha);
    draw_set_halign(old_halign);
    draw_set_valign(old_valign);
}
