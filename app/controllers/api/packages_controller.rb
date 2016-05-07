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

      metadata = package_params[:metadata]
      @package = Package.find_by(name: metadata[:name])

      if @package.present?
        metadata.delete :name
        version = metadata.delete(:version)
        @package.update metadata

        @package.versions.build(
          version: version,
          archive: package_params[:archive]
        )

        if @package.save
          render json: @package
        else
          render json: {error: @package.errors}
        end
      else
        version = metadata.delete(:version)
        @package = Package.new(metadata)
        @package.user = @user

        if @package.save
          @package.versions.build(
            version: version,
            archive: package_params[:archive]
          )

          if @package.save
            render json: @package
          else
            render json: {error: @package.errors}
          end
        else
          render json: {error: @package.errors}
        end
      end

    else
      head :unauthorized
    end
  end

  # DELETE /api/packages/:name
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
    params.permit(
      :token,
      :archive,
      :version,
      :manifest
    )
  end
end
