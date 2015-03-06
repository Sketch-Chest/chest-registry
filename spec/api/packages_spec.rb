require 'rails_helper'

RSpec.describe PackagesController do
  it 'can get package info' do
    @package = Fabricate(:package)

    get "/api/packages/#{@package.name}"
    expect(response.status).to be(200)
    expect(JSON.parse(response.body)['name']).to eq(@package.name)
  end

  it 'cat publish package' do
    @user = Fabricate(:user)

    metadata = {
      name: 'StickyGrid',
      description: 'This is awesome plugin.',
      readme: "# StickyGrid\nThis is greatest plugin",
      repository: 'https://github.com/uetchy/Sketch-StickyGrid'
    }
    data = fixture_file_upload('/files/Sketch-StickyGrid.zip', 'application/octet-stream', :binary)
    post "/api/packages", token: @user.token, metadata: metadata.to_json, archive: data
    expect(response.status).to be(200)
  end
end
