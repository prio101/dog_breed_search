class HomesController < ApplicationController
  before_action :validate_search_params, only: :search

  def index
  end

  def search
    query_downcased = search_params[:query].downcase

    response = HTTParty.get("https://dog.ceo/api/breed/#{query_downcased}/images/random")

    if success_response?(response["status"])
      @image = response['message']
      render turbo_stream: [ turbo_stream.update('image_container',
                                                 partial: 'partials/image', locals: { image_url: @image,
                                                 breed_name: query_downcased  })]
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
                                                locals: { error_message: error_message })
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
