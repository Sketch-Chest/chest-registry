class PackagesController < ApplicationController
  before_action :set_package, only: [:show]

  # GET /
  def index
    @packages = Package.all
  end

  # GET /packages/:name
  def show
  end

  def create
    @package = Package.new(package_params)
  end

  private
  def set_package
    @package = Package.find_by(name: params[:id])
  end

  def package_params
    params.require(:package).permit(:name, :user, :manifest, :password_confirmation)
  end
end
