class UrlsController < ApplicationController
 
 before_action :authenticate

  def create
    @url = Url.new(url_params)
    if @url.save
      render json: { short_url: short_url(@url.short_code) }, status: :created
    else
      render json: { errors: @url.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def redirect
    @url = Url.find_by(short_code: params[:short_code])
    if @url
      redirect_to @url.original_url, allow_other_host: true
    else
      render plain: 'URL not found', status: :not_found
    end
  end

  def index
    @urls = Url.all
    render json: @urls, status: :ok
  end

   def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == 'hello' && password == '123'
    end
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end

  def short_url(short_code)
    request.base_url + '/' + short_code
  end
end

class Url < ApplicationRecord
  before_create :generate_short_code

  private

  def generate_short_code
    self.short_code = SecureRandom.uuid[0..5]
  end
end
