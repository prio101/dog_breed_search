class HomesController < ApplicationController
  def index
  end

  def search
    response = HTTParty.get("https://dog.ceo/api/breed/#{search_params[:query]}/images/random")

    if response.code == 200
      @image = response['message']
    elsif response.code == 404
      flash[:error] = 'Please enter a valid dog breed...'
    end
  end

  private

  def search_params
    raise ActionController::ParameterMissing if params[:search].blank?

    params.require(:search).permit(:query)

  rescue ActionController::ParameterMissing
    flash[:error] = 'Please enter a search query, To search the dog breed'
  end
end
