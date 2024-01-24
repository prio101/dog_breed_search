class HomesController < ApplicationController
  before_action :validate_search_params, only: :search

  def index
  end

  def search
    query_downcased = search_params[:query].downcase
    response = HTTParty.get("https://dog.ceo/api/breed/#{query_downcased}/images/random")


    if success_response?(response["status"])
      @image = response['message']

    elsif error_response?(response["status"])
      flash[:error] = 'Please enter a valid dog breed...'
    else
      flash[:error] = 'Internal server error...'
      redirect_to root_path
    end
  end

  private

  def validate_search_params
    if params[:search][:query].blank?
      flash[:error] = 'Please enter a dog breed...'
      return redirect_to root_path
    end
  end

  def success_response?(status)
    status == "success".freeze
  end

  def error_response?(status)
    status == "error".freeze
  end

  def search_params
    params.require(:search).permit(:query)
  end
end
