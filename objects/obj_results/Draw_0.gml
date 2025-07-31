var result_x = 200;
var result_y = 150;

var good = global.npc_reactions.Good;
var neutral = global.npc_reactions.Neutral;
var bad = global.npc_reactions.Bad;

var total = good + neutral + bad;

var overall = "";
if (total > 0) {
    if (good / total >= 0.8) overall = "Outstanding!";
    else if (good / total >= 0.5) overall = "Decent job.";
    else overall = "You can do better...";
} else {
    overall = "No Data";
}

draw_set_color(c_white);
draw_text(result_x, result_y, "=== Day 1 Results ===");
draw_text(result_x, result_y + 40, "Good Reactions: " + string(good));
draw_text(result_x, result_y + 70, "Neutral Reactions: " + string(neutral));
draw_text(result_x, result_y + 100, "Bad Reactions: " + string(bad));
draw_text(result_x, result_y + 140, "Overall: " + overall);

draw_text(result_x, result_y + 200, "Time Reached: " + global.time_label);
draw_text(result_x, result_y + 250, "Click to End Day.");

if (mouse_check_button_pressed(mb_left)) {
    room_goto(rm_kitchen); // Restart for next day or continue
}
