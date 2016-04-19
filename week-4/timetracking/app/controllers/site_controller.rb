class SiteController < ApplicationController

  def home
    render "home"
  end

  def contact
    render "contact"
  end

  def say_name
    @name = params[:name]
    render "say_name"
  end

  def calculator
    render "calculator"
  end

  def calculate
    @first = params[:first_num].to_i
    @second = params[:second_num].to_i
    @sum = @first + @second
    render "calculate"
  end

end
