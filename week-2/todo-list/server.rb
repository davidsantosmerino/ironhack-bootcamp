require "pry"
require_relative "models/todo-list"
require_relative "models/task"
require "sinatra"
require "sinatra/reloader"

todo_list = TodoList.new "David"

get "/tasks/?:action?" do
  @action = params[:action]
  todo_list.load_tasks
  @pending_tasks = todo_list.pending_tasks
  @completed_tasks = todo_list.completed_tasks
  erb(:tasks)
end

get "/new_task" do
  erb(:new_task)
end

post "/create_task" do
  content = params[:content]
  task = Task.new content
  todo_list.add_task task
  todo_list.save
  redirect "/tasks"
end

get "/complete_task/:id" do
  id = params[:id].to_i
  task = todo_list.find_task_by_id id
  task.complete!
  todo_list.save

  redirect "/tasks/completed"
end

get "/delete_task/:id" do
  id = params[:id].to_i
  task = todo_list.remove_task id
  todo_list.save

  redirect "/tasks/deleted"
end
