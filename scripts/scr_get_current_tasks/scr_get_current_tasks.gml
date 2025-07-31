/// scr_get_current_tasks()
function get_current_tasks() {
    if (global.time_phase == "Morning") {
        return ["Cut Carrots", "Prep Meat"];
    } 
    else if (global.time_phase == "Afternoon") {
        return ["Add Meat", "Add Carrots", "Cook in Pot"];
    } 
    else if (global.time_phase == "Evening") {
        return ["Serve to People"];
    } 
    else if (global.time_phase == "Night") {
        return ["Talk to People", "Get Feedback"];
    }
    return [];
}
