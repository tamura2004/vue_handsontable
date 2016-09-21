require 'rails_helper'

RSpec.describe Member, type: :model do
  let(:member){FactoryGirl.build(:member)}
  it {expect(member).to be_valid}
end
