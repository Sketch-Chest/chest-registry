class PackagesController < ApplicationController
  before_action :set_package, only: [:show]

  # GET /
  def index
    @packages = Package.all
  end

  # GET /packages/:name
  def show
  end

  private
  def set_package
    @package = Package.find_by(name: params[:id])
  end
end
