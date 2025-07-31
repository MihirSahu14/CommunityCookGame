// === INITIALIZE GLOBAL VARS IF THEY DON'T EXIST ===
if (!variable_global_exists("cooking_progress")) global.cooking_progress = 0;
if (!variable_global_exists("heat")) global.heat = 0;
if (!variable_global_exists("cooked")) global.cooked = false;
if (!variable_global_exists("overheated")) global.overheated = false;
if (!variable_global_exists("pot_contents")) global.pot_contents = [];
if (!variable_global_exists("cooking_started")) global.cooking_started = false;
if (!variable_global_exists("frame_timer")) global.frame_timer = 0;

// === LINK TO GLOBAL ===
cooking_progress = global.cooking_progress;
heat = global.heat;
cooked = global.cooked;
overheated = global.overheated;
contents = global.pot_contents;
cooking_started = global.cooking_started;
frame_timer = global.frame_timer;

// === COOL ON RETURN FROM MINIGAME ===
if (variable_global_exists("returning_from_minigame") && global.returning_from_minigame) {
    heat -= irandom_range(30, 50);
    heat = max(0, heat);

    if (heat < 100) {
        overheated = false;
        show_debug_message("✅ Pot cooled! Back to cooking.");
    } else {
        show_debug_message("⚠️ Still too hot after cooling.");
    }

    global.returning_from_minigame = false;
}
