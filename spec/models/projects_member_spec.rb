require 'rails_helper'

RSpec.describe ProjectsMember, type: :model do
  let(:projects_member){FactoryGirl.build(:projects_member)}
  it {expect(projects_member).to be_valid}
end
