class ConcertsController < ApplicationController
  def index
    @concerts = Concert.where("date >= ?", DateTime.now)
  end
end
