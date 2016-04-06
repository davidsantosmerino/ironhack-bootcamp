require "rspec"
require ".././models/task"
require ".././models/todo-list"

describe TodoList do
  let(:todolist){ TodoList.new "user" }
  let(:defaultask){ Task.new "default" }

  describe "check that the todolist is created with the right parameters" do

    it "should return that the number of tasks is 0 when create" do
      expect(todolist.tasks.size).to eq(0)
    end

    it "should return that the user_name is equal to the passed one" do
      expect(todolist.user_name).to eq("user")
    end
  end

  describe "check that todo list actions are working" do

    it "should return the tasks size is increased by one after add_task" do
      expect{todolist.add_task defaultask}.to change{todolist.tasks.size}.from(todolist.tasks.size).to(todolist.tasks.size+1)
    end

    it "should return the task for an existing id" do
      todolist.add_task defaultask
      expect(todolist.find_task_by_id 2).to be_a_kind_of(Task)
    end

    it "should return nil for a non existing id" do
      expect(todolist.find_task_by_id 10).to eq(nil)
    end

    it "should change the tasks size after remove_task for an existing id" do
      todolist.add_task defaultask
      expect{todolist.remove_task 3}.to change{todolist.tasks.size}.from(todolist.tasks.size).to(todolist.tasks.size-1)
    end

    it "should not change the tasks size after remove_task for a non existing id " do
      expect{todolist.remove_task 10}.to change{todolist.tasks.size}.by(0)
    end

    it "should return at ordered array after sort_by_created with ASC" do
      first_task = Task.new "empty"
      second_task = Task.new "empty"
      third_task = Task.new "empty"
      todolist.add_task third_task
      todolist.add_task second_task
      todolist.add_task first_task
      expect(todolist.sort_by_created "ASC").to eq([first_task,second_task,third_task])
    end

    it "should return at ordered array after sort_by_created with DESC" do
      first_task = Task.new "empty"
      second_task = Task.new "empty"
      third_task = Task.new "empty"
      todolist.add_task first_task
      todolist.add_task second_task
      todolist.add_task third_task
      expect(todolist.sort_by_created "DESC").to eq([third_task,second_task,first_task])
    end

  end


end
