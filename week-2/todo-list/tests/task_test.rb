require "rspec"
require ".././models/task"

describe Task do
  default_content = "task one"
  new_content = "task modified"
  let(:task){ Task.new default_content }

  describe "check that the task is created with the default parameters" do
    it "should return 1 for the first id" do
      expect(task.id).to eq(1)
    end

    it "should return the created_at is same at Time.new" do
      expect(task.created_at.to_i).not_to eq(be_falsy)
    end

    it "should the complete? is false by default" do
      expect(task.complete?).to eq(false)
    end

    it "should return the same content passed on initialize" do
      expect(task.content).to eq(default_content)
    end
  end

  describe "check that the complete flag values" do
    it "should return true after complete!" do
      task.complete!
      expect(task.complete?).to eq(true)
    end

    it "should return false afer make_incomplete!" do
      task.make_incomplete!
      expect(task.complete?).to eq(false)
    end
  end

  describe "check that the content value can be modfied" do
    it "should return the new content value after content!" do
      task.update_content! new_content
      expect(task.content).to eq(new_content)
    end
    it "should return the updated_at when is update_content! is executed" do
      expect{task.update_content! new_content}.to change{task.updated_at}.from(nil).to(be_truthy)
    end
  end

end
