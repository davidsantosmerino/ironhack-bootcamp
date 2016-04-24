class ConcertsController < ApplicationController
  def index
    @concerts = Concert.where("date >= ?", DateTime.now)
  end
  def show
    @concert = Concert.find_by(id: params[:id])
  end
  def new
    @concert = Concert.new
  end
  def create
    @concert = Concert.new(concert_params)
    redirect_to root_path if @concert.save
  end

  private
  def concert_params
    params.require(:concert).permit(:artist, :venue, :city, :price, :date, :description, :asset)
  end
end
