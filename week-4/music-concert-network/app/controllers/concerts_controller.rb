class ConcertsController < ApplicationController
  def index
    @today_concerts = Concert.today
    @this_month_concerts = Concert.this_month
  end
  def show
    @concert = Concert.find_by(id: params[:id])
  end
  def new
    @concert = Concert.new
  end
  def create
    @concert = Concert.new(concert_params)
    if @concert.valid?
      @concert.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def concert_params
    params.require(:concert).permit(:artist, :venue, :city, :price, :date, :description, :asset)
  end
end
