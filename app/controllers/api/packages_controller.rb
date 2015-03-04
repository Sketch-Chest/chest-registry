class Api::PackagesController < ApplicationController
  skip_before_filter :require_login
  before_action :set_package, only: [:show]

  # GET /api/packages/:name
  def show
  end

  # POST /api/packages
  def create
    if @user = User.find_by(token: package_params[:token])
      metadata = JSON.parse(package_params[:metadata])
      render json: {status: metadata}
    else
      head :unauthorized
    end
  end

  private
  def set_package
    @package = Package.find_by(name: params[:id])
  end

  def package_params
    params.permit(:token, :metadata)
  end
end
