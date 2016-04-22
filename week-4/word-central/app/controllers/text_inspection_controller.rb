class TextInspectionController < ApplicationController

  def new
    render "new"
  end

  def count
    @text = params[:text_inspection][:user_text]
    words = @text.split
    frequency_hash = Hash.new(0)
    words.each { |word| frequency_hash[word] += 1 }
    frequency_hash = frequency_hash.sort { |a, b| b[1] <=> a[1] }
    @frequency = frequency_hash[0..10]
    @count = words.size / 275
    render "count"
  end

end
