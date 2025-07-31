function scr_mark_task_done(task_name) {
    for (var i = 0; i < array_length(global.todo_list); i++) {
        if (global.todo_list[i] == task_name) {
            array_delete(global.todo_list, i, 1);
            break;
        }
    }
}
