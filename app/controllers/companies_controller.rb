class CompaniesController < ApplicationController

  before_action :get_names

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find_by(:stock_exchange => params[:stock_exchange], :symbol => params[:symbol])
  end

end
