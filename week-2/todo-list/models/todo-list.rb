require_relative 'todo-list-store'

class TodoList
    attr_reader :user_name,:tasks

    def initialize user_name
       @user_name = user_name
       @tasks = []
    end

    def add_task task
      @tasks << task
    end

    def remove_task id
      @tasks.delete_if {|task| task.id == id }
    end

    def find_task_by_id id
      index = @tasks.index {|task| task.id == id }
      return @tasks[index] unless index.nil?
    end

    def pending_tasks
      @tasks.select {|task| not task.complete?}
    end

    def completed_tasks
      @tasks.select {|task| task.complete?}
    end

    def sort_by_created direction
      case direction
      when "ASC"
        sorted_tasks = @tasks.sort { | task1, task2 | task1.created_at <=> task2.created_at }
      when "DESC"
        sorted_tasks = @tasks.sort { | task1, task2 | task2.created_at <=> task1.created_at }
      end

      sorted_tasks
    end

    def save
      TodoListStore.save @user_name, @tasks
    end

    def load_tasks
      @tasks = TodoListStore.load_tasks @user_name
    end
end
