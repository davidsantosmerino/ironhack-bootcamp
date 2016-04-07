require 'yaml/store'

module TodoListStore
  YML_PATH = "tasks.yml"
  @tasks_store = YAML::Store.new(YML_PATH)

  def self.save user_name, tasks
    @tasks_store.transaction do
        @tasks_store[user_name] = tasks
    end
  end

  def self.load_tasks user_name
    @tasks_store.transaction do
        @tasks_store[user_name]
    end
  end
end
