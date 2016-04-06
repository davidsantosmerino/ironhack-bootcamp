class Task
  attr_reader :id, :created_at, :updated_at, :content
  @@current_id = 1

  def initialize content
    @id = @@current_id
    @created_at = Time.new
    @updated_at = nil
    @content = content
    @complete = false
    @@current_id += 1
  end

  def complete?
    @complete
  end

  def complete!
    @complete = true
  end

  def make_incomplete!
    @complete = false
  end

  def update_content! new_content
    @content = new_content
    @updated_at = Time.new
  end
  
end
