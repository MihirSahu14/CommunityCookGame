name = "Marco"

nutrient_pref = {
    fullness: 8,
    vitamins: 3,
    protein: 2,
    salt: 1
};

dialogue = "I haven’t eaten in days. I need something filling.";
has_been_served = false;
served_dish = undefined;
ui_open = false;
show_intro = true;
reaction = "";
intro_timer = 0;


image_xscale = 6;
image_yscale = 6;

calculate_match_percentage = function () {
    if (!is_struct(served_dish)) return 0;

    var nutrients = served_dish.nutrients;
    var need = nutrient_pref;

    var match_score = 0;
    if (abs(nutrients.fullness - need.fullness) <= 2) match_score += 25;
    if (abs(nutrients.vitamins - need.vitamins) <= 2) match_score += 25;
    if (abs(nutrients.protein - need.protein) <= 2) match_score += 25;
    if (abs(nutrients.salt - need.salt) <= 1) match_score += 25;

    return match_score;
};
