class AirplanesController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @airplanes = Airplane.all
  end

  def show
    @airline = Airline.find_by(:iata => params[:airline_iata])
    @airplane = @airline.airplanes.find_by(:registration_code => params[:registration_code])
  end

end
