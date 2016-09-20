require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group){FactoryGirl.build(:group)}
  it {expect(group).to be_valid}
end
