class API::PackagesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token

  before_action :set_package, only: [:show, :download, :destroy]

  # GET /api/packages/:name
  def show
  end

  # POST /api/packages
  def create
    if @user = User.find_by(token: package_params[:token])
      metadata = JSON.parse(package_params[:metadata])

      @package = Package.find_by(name: metadata['name'])
      if @package.present?
        @version = @package.versions.build(
          version: metadata['version'],
          archive: package_params[:archive]
        )

        if @version.save
          render json: @package
        else
          render json: {error: @version.errors}
        end
      else
        @package = Package.new(
          name: metadata['name'],
          description: metadata['description'],
          readme: metadata['readme'],
          homepage: metadata['homepage'],
          keywords: metadata['keywords'].join(','),
          repository_type: metadata['repository']['type'],
          repository_url: metadata['repository']['url'],
          authors: metadata['authors'], #array
          user: @user,
        )
        if @package.save
          @version = @package.versions.build(
            version: metadata['version'],
            archive: package_params[:archive]
          )

          if @version.save
            render json: @package
          else
            render json: {error: @version.errors}
          end
        else
          render json: {error: @package.errors}
        end
      end

    else
      head :unauthorized
    end
  end

  def destroy
    if @user = User.find_by(token: package_params[:token])
      if @package.user == @user
        @package.destroy
        render json: {status: :success}
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
    params.permit(:token, :metadata, :archive, :version)
  end
end
