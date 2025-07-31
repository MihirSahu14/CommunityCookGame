// === Game Setup (persist-safe) ===
if (!variable_global_exists("game_phase")) {
    global.time_remaining = 60;
    global.game_phase = "morning";
    global.time_label = "9:00 Morning";
    global.phase_locked = false;
}

if (!variable_global_exists("game_day")) {
    global.game_day = 1;
}

// === Pantry setups per day ===
// === Day 1: Easy — Can make at least 5 dishes (10 ingredients) + buffer
global.pantry_day_1 = [
    { name: "Potatoes",     fullness: 5, vitamins: 3, protein: 1, salt: 0, is_spice: false, is_choppable: false, is_mashable: true, available: 5 },
    { name: "Canned Meat",  fullness: 2, vitamins: 0, protein: 4, salt: 3, is_spice: false, is_choppable: false, is_mashable: true, available: 5 },
    { name: "Rice",         fullness: 3, vitamins: 3, protein: 0, salt: 3, is_spice: false, is_choppable: false, is_mashable: true, available: 4 },
    { name: "Carrot",       fullness: 3, vitamins: 4, protein: 0, salt: 2, is_spice: false, is_choppable: true,  is_mashable: false, available: 4 },
    { name: "Dried Bean",   fullness: 3, vitamins: 2, protein: 4, salt: 0, is_spice: false, is_choppable: false, is_mashable: true, available: 4 },
    { name: "Cabbage",      fullness: 2, vitamins: 5, protein: 1, salt: 1, is_spice: false, is_choppable: true,  is_mashable: false, available: 4 }
];
// Total ingredients: 26 (room for choice and mistakes)


// === Day 2: Medium — Enough for 7 dishes (14 ingredients) + light buffer
global.pantry_day_2 = [
    { name: "Potatoes",     fullness: 5, vitamins: 3, protein: 1, salt: 0, is_spice: false, is_choppable: false, is_mashable: true, available: 5 },
    { name: "Canned Meat",  fullness: 2, vitamins: 0, protein: 4, salt: 3, is_spice: false, is_choppable: false, is_mashable: true, available: 5 },
    { name: "Rice",         fullness: 3, vitamins: 3, protein: 0, salt: 3, is_spice: false, is_choppable: false, is_mashable: true, available: 3 },
    { name: "Carrot",       fullness: 3, vitamins: 4, protein: 0, salt: 2, is_spice: false, is_choppable: true,  is_mashable: false, available: 3 },
    { name: "Dried Bean",   fullness: 3, vitamins: 2, protein: 4, salt: 0, is_spice: false, is_choppable: false, is_mashable: true, available: 3 },
    { name: "Cabbage",      fullness: 2, vitamins: 5, protein: 1, salt: 1, is_spice: false, is_choppable: true,  is_mashable: false, available: 3 }
];
// Total ingredients: 22 (just enough + 1 or 2 extras)


/* === Day 3: Challenging — Just enough for 9 dishes (18 ingredients) + 2 extras === */
global.pantry_day_3 = [
    { name: "Potatoes",     fullness: 5, vitamins: 3, protein: 1, salt: 0, is_spice: false, is_choppable: false, is_mashable: true, available: 5 },
    { name: "Canned Meat",  fullness: 2, vitamins: 0, protein: 4, salt: 3, is_spice: false, is_choppable: false, is_mashable: true, available: 5 },
    { name: "Rice",         fullness: 3, vitamins: 3, protein: 0, salt: 3, is_spice: false, is_choppable: false, is_mashable: true, available: 2 },
    { name: "Carrot",       fullness: 3, vitamins: 4, protein: 0, salt: 2, is_spice: false, is_choppable: true,  is_mashable: false, available: 2 },
    { name: "Dried Bean",   fullness: 3, vitamins: 2, protein: 4, salt: 0, is_spice: false, is_choppable: false, is_mashable: true, available: 2 },
    { name: "Cabbage",      fullness: 2, vitamins: 5, protein: 1, salt: 1, is_spice: false, is_choppable: true,  is_mashable: false, available: 2 }
];
// Total ingredients: 18 + 2 extra = 20 total — enough if player plays smart


// === Assign pantry for current day ===
var pantry_source;

switch (global.game_day) {
    case 1: pantry_source = global.pantry_day_1; break;
    case 2: pantry_source = global.pantry_day_2; break;
    case 3: pantry_source = global.pantry_day_3; break;
    default: pantry_source = global.pantry_day_1; break;
}

global.pantry = array_create(array_length(pantry_source));
for (var i = 0; i < array_length(pantry_source); i++) {
    global.pantry[i] = pantry_source[i];
}


if (!variable_global_exists("recipe_list")) {
    global.recipe_list = [
        {ingredients: ["Potatoes", "Potatoes"], result: "Potato soup"},
        {ingredients: ["Potatoes", "Canned Meat"], result: "Meat potato hash"},
        {ingredients: ["Potatoes", "Rice"], result: "Aloo rice"},
        {ingredients: ["Potatoes", "Carrot"], result: "Mix soup"},
        {ingredients: ["Potatoes", "Dried Bean"], result: "Jacket potatoes"},
        {ingredients: ["Potatoes", "Cabbage"], result: "Colcannon"},
        {ingredients: ["Canned Meat", "Canned Meat"], result: "Meat loaf"},
        {ingredients: ["Canned Meat", "Rice"], result: "Beef bowl"},
        {ingredients: ["Canned Meat", "Carrot"], result: "Mix stew"},
        {ingredients: ["Canned Meat", "Dried Bean"], result: "Chili"},
        {ingredients: ["Canned Meat", "Cabbage"], result: "Cabbage roll"},
        {ingredients: ["Rice", "Rice"], result: "Cooked rice"},
        {ingredients: ["Rice", "Carrot"], result: "Fried rice"},
        {ingredients: ["Rice", "Dried Bean"], result: "Mix bowl"},
        {ingredients: ["Rice", "Cabbage"], result: "Mix soup"},
        {ingredients: ["Carrot", "Carrot"], result: "Carrot stew"},
        {ingredients: ["Carrot", "Dried Bean"], result: "Vegan patties"},
        {ingredients: ["Carrot", "Cabbage"], result: "Cabbage-Carrot Casserole"},
        {ingredients: ["Dried Bean", "Dried Bean"], result: "Lentil soup"},
        {ingredients: ["Dried Bean", "Cabbage"], result: "Mix soup"},
        {ingredients: ["Cabbage", "Cabbage"], result: "Cabbage soup"},
        {ingredients: ["Carrot", "Canned Meat"], result: "Mix stew"},
        {ingredients: ["Rice", "Canned Meat"], result: "Beef bowl"},
        {ingredients: ["Rice", "Potatoes"], result: "Aloo rice"},
        {ingredients: ["Carrot", "Rice"], result: "Fried rice"}
    ];
}

if (!variable_global_exists("result_prompt_shown")) {
    global.result_prompt_shown = false;
}

if (!variable_global_exists("npc_reactions")) {
    global.npc_reactions = {
        Good: 0,
        Neutral: 0,
        Bad: 0
    };
}

global.todo_list = [];
global.todo_done = [];
global.all_possible_tasks = [];

show_phase_prompt = false;
button_yes_hovered = false;
button_no_hovered = false;
show_result_popup = false;

if (!variable_global_exists("npcs_spawned")) {
    global.npcs_spawned = false;
}

if (!variable_global_exists("community_reqs")) {
    global.community_reqs = [];
}
