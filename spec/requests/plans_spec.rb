require 'rails_helper'

RSpec.describe "Plans", type: :request do
  before { create :group, { id: 3 } }
  before { create :plan }
  let(:params){{ plan: attributes_for(:plan) }}

  # describe "GET /plans" do
  #   it{should == 200}
  # end

  # describe "GET /plans/new" do
  #   it{should == 200}
  # end

  # describe "GET /plans/compare" do
  #   it{should == 200}
  # end

end
