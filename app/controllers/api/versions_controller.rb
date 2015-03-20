class API::VersionsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token

  before_action :set_version, only: [:show, :download]

  # GET /api/packages/:id/versions
  def index
    @package = Package.find_by(name: params[:package_id])
    @versions = @package.versions
  end

  # GET /api/packages/:id/versions/:version
  def show
    unless @version.present?
      return render json: {error: 404}
    end
  end

  # GET /api/packages/:id/versions/:version/download
  def download
    unless @version.present?
      return render json: {error: 404}
    end

    @package.increase_download_count
    send_file @version.archive.path, type: @version.archive_content_type, disposition: 'inline'
  end

  private
  def set_version
    @package = Package.find_by(name: params[:package_id])

    unless @package.present?
      return head 404
    end

    required_version = params[:id]
    @version = required_version == 'latest' ? @package.versions.last : @package.versions.find_by(version: required_version)

    unless @version.present?
      return head 404
    end
  end
end
