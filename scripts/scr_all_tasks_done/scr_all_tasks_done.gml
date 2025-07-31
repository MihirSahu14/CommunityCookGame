function all_tasks_done() {
    // If there are no tasks or all are completed, return true
    if (array_length(global.todo_list) == 0) {
        return true;
    }
    
    for (var i = 0; i < array_length(global.todo_list); i++) {
        if (!global.todo_done[i]) { // If any task is not done, return false
            return false;
        }
    }
    return true; // All tasks are completed
}
