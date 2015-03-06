class Api::PackagesController < ApplicationController
  skip_before_filter :require_login
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token

  before_action :set_package, only: [:show, :destroy]

  # GET /api/packages/:name
  def show
    puts "="*30
    puts request.url
    puts request.body.read
    puts "="*30
  end

  # POST /api/packages
  def create
    if @user = User.find_by(token: package_params[:token])
      metadata = JSON.parse(package_params[:metadata])

      @package = Package.new(
        name: metadata['name'],
        description: metadata['description'],
        readme: metadata['readme'],
        homepage: metadata['homepage'],
        repository: metadata['repository'],
        user: @user,
        )

      if @package.save
        @package.versions.create(
          version: metadata['version'],
          archive: package_params[:archive])
        render json: @package
      else
        render json: {error: @package.errors}
      end
    else
      head :unauthorized
    end
  end

  def destroy
    if @user = User.find_by(token: package_params[:token])
      if @package.user == @user
        render json: @package.destroy
      else
        head :unpermitted
      end
    else
      head :unauthorized
    end
  end

  private
  def set_package
    @package = Package.find_by(name: params[:id])
  end

  def package_params
    params.permit(:token, :metadata, :archive)
  end
end
