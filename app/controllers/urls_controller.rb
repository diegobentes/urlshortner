class UrlsController < ApplicationController
  before_action :authorize_request
  before_action :set_url, only: [:show, :update, :destroy]

  # GET /urls
  def index
    @urls = @current_user.front_urls
    render json: @urls
  end

  # GET /urls/1
  def show
    render json: @url
  end

  # POST /urls
  def create
    @url = Url.new(url_params)
    @url.user =  @current_user

    if @url.save
      render json: @url, status: :created, location: @url
    else
      render json: @url.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /urls/1
  def update
    if @url.update(url_params)
      render json: @url
    else
      render json: @url.errors, status: :unprocessable_entity
    end
  end

  # DELETE /urls/1
  def destroy
    @url.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def url_params
      params.require(:url).permit(:short_url, :long_url, :status)
    end
end
