class AsciisController < ApplicationController

  def new
    render "new"
  end

  def create
    @text = params[:asciis][:user_text]
    artii = Artii::Base.new
    @asciis_text = artii.asciify @text

  end

end
