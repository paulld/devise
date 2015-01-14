class CompaniesController < ApplicationController

  def index
    @companies = params[:stock_exchange] ? Company.where(:stock_exchange => params[:stock_exchange]) : Company.all
  end

  def show
    @company = Company.find_by(:stock_exchange => params[:stock_exchange], :symbol => params[:symbol])
  end

end
