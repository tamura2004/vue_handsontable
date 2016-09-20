require 'rails_helper'

RSpec.describe "departments/index", type: :view do
  before(:each) do
    assign(:departments, [
      Department.create!(
        :name => "Name1"
      ),
      Department.create!(
        :name => "Name2"
      )
    ])
  end

  it "renders a list of departments" do
    render
    assert_select "ul>li>a", :text => "部".to_s, :count => 1
  end
end
