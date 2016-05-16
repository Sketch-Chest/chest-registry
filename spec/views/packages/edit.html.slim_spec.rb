require 'rails_helper'

RSpec.describe "packages/edit", :type => :view do
  before(:each) do
    @package = assign(:package, Package.create!(
      :title => "MyString",
      :repository => "MyString"
    ))
  end

  it "renders the edit package form" do
    render

    assert_select "form[action=?][method=?]", package_path(@package), "post" do

      assert_select "input#package_title[name=?]", "package[title]"

      assert_select "input#package_repository[name=?]", "package[repository]"
    end
  end
end
