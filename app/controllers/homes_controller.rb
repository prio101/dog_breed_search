class HomesController < ApplicationController
  include HomesHelper

  before_action :validate_search_params, only: :search

  def index
  end

  def search
    breed_name_formatted = breed_name_formatted(search_params[:query])

    response = HTTParty.get("https://dog.ceo/api/breed/#{breed_name_formatted}/images/random")

    if success_response?(response["status"])
      @image = response['message']
      render turbo_stream: [ turbo_stream.update('image_container',
                                                 partial: 'partials/image', locals: { image_url: @image,
                                                 breed_name: breed_name_formatted  })]
    elsif error_response?(response["status"])
      render_error(response["message"])
    else
      render_error('Internal server error...')
      redirect_to root_path
    end
  end

  private

  def validate_search_params
    if params[:search][:query].blank?
      render_error('Please enter a breed name to search for')
      return
    end
  end

  def render_error(error_message)
    render turbo_stream: turbo_stream.update('error_container',
                                              partial: 'partials/errors',
                                              locals: {
                                                  error_message: error_message
                                              })
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
