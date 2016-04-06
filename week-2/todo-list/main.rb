require "./models/todo-list"
require "./models/task"
require "pry"


todo_list = TodoList.new "David"
todo_list.load_tasks
todo_list.find_task_by_id 1
