class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find_by(:symbol => params[:symbol])
  end

end
