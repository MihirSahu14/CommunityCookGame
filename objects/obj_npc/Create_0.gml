// Each NPC has their nutrient needs
nutrient_pref = {
    fullness: irandom_range(3, 6),
    vitamins: irandom_range(2, 5),
    protein: irandom_range(2, 5),
    salt: irandom_range(1, 4)
};

has_been_served = false;
served_dish = undefined;
ui_open = false;
reaction = "";  // NPC reaction will be stored here

// Helper function to calculate the nutrient match percentage
function calculate_match_percentage() {
    var match = 0;
    
    // Compare fullness
    match += (min(nutrient_pref.fullness, served_dish.nutrients.fullness) / nutrient_pref.fullness) * 100;
    // Compare vitamins
    match += (min(nutrient_pref.vitamins, served_dish.nutrients.vitamins) / nutrient_pref.vitamins) * 100;
    // Compare protein
    match += (min(nutrient_pref.protein, served_dish.nutrients.protein) / nutrient_pref.protein) * 100;
    // Compare salt
    match += (min(nutrient_pref.salt, served_dish.nutrients.salt) / nutrient_pref.salt) * 100;
    
    // Average the match
    match /= 4;
    
    return match;
}

persistent = true;