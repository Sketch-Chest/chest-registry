require 'rails_helper'

RSpec.describe "packages/index", :type => :view do
  before(:each) do
    assign(:packages, [
      Package.create!(
        :title => "Title",
        :repository => "Repository"
      ),
      Package.create!(
        :title => "Title",
        :repository => "Repository"
      )
    ])
  end

  it "renders a list of packages" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Repository".to_s, :count => 2
  end
end
