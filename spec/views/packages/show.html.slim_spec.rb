require 'rails_helper'

RSpec.describe "packages/show", :type => :view do
  before(:each) do
    @package = assign(:package, Package.create!(
      :title => "Title",
      :repository => "Repository"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Repository/)
  end
end
