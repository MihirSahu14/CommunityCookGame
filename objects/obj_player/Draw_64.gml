// === Hide outside kitchen ===
if (room != rm_kitchen || string_pos("minigame", room_get_name(room)) > 0) {
    exit;
}

// === Dynamic Top-Right GUI (Below Time Box) ===
var screen_right = display_get_gui_width();
var box_margin = 20;
var box_x = screen_right - 380;
var box_y = 210;
var box_width = 350;
var y_pos = box_y + 20;

// === Background Box ===
draw_set_alpha(0.8);
draw_set_color(c_black);
draw_rectangle(box_x, box_y, box_x + box_width, box_y + 700, false); // increased height for more content
draw_set_alpha(1);
draw_set_color(c_white);

// === Inventory Header ===
draw_text(box_x + 20, y_pos, "== Inventory ==");
y_pos += 30;

// === Inventory Items ===
for (var i = 0; i < array_length(inventory); i++) {
    var item = inventory[i];
    draw_text(box_x + 20, y_pos, item.name + " x" + string(item.qty));
    draw_text(box_x + 180, y_pos, "F:" + string(item.fullness) + " V:" + string(item.vitamins) + " P:" + string(item.protein) + " S:" + string(item.salt));
    y_pos += 30;
}

// === Prepared Header ===
y_pos += 20;
draw_text(box_x + 20, y_pos, "== Prepared ==");
y_pos += 30;

// === Prepared Items ===
for (var i = 0; i < array_length(prepared); i++) {
    var item = prepared[i];
    draw_text(box_x + 20, y_pos, item.name + " x" + string(item.qty));
    draw_text(box_x + 180, y_pos, "F:" + string(item.fullness) + " V:" + string(item.vitamins) + " P:" + string(item.protein) + " S:" + string(item.salt));
    y_pos += 30;
}

// === Cooked Dishes Header ===
y_pos += 20;
draw_text(box_x + 20, y_pos, "== Cooked Dishes ==");
y_pos += 30;

// === Show Each Cooked Dish with Quantity ===
for (var i = 0; i < array_length(cooked_dishes); i++) {
    var d = cooked_dishes[i];
    var label = d.name + " x" + string(d.qty) + (d.burnt ? " (Burnt)" : "") +
        " F:" + string(d.nutrients.fullness) +
        " V:" + string(d.nutrients.vitamins) +
        " P:" + string(d.nutrients.protein) +
        " S:" + string(d.nutrients.salt);
    draw_text(box_x + 20, y_pos, "- " + label);
    y_pos += 25;
}

// === Community Needs ===
y_pos += 20;
draw_text(box_x + 20, y_pos, "== Community Needs ==");
y_pos += 30;

for (var i = 0; i < array_length(global.community_reqs); i++) {
    var req = global.community_reqs[i];
    
    var line = string(req.name) + ": F:" + string(req.fullness) +
               " V:" + string(req.vitamins) +
               " P:" + string(req.protein) +
               " S:" + string(req.salt);
    
    draw_text(box_x + 20, y_pos, "- " + line);
    y_pos += 25;
}
