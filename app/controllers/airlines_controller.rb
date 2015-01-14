class AirlinesController < ApplicationController

  def index
    @airlines = Airline.all
  end

  def show
    @airline = Airline.find_by(:iata => params[:iata])
  end

end
