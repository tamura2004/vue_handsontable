require 'rails_helper'

RSpec.describe "projects/members/index", type: :view do
  before(:each) do
    assign(:assignment, create(:assign))
    render
  end

  it "show project" do
    expect(rendered).to match /:project=/
  end

  it "show members" do
    expect(rendered).to match /:members=/
  end

end
