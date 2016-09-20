require 'rails_helper'

RSpec.describe Department, type: :model do
  it {
    expect(FactoryGirl.build(:department)).to be_valid
  }
end
