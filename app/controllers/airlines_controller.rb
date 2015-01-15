class AirlinesController < ApplicationController

  def index
    @airlines = Airline.all
  end

  def show
    @airline = Airline.find_by(:icao => params[:icao])
  end

end
