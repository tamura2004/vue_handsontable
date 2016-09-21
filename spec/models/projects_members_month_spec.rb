require 'rails_helper'

RSpec.describe ProjectsMembersMonth, type: :model do
  let(:projects_members_month){FactoryGirl.build(:projects_members_month)}
  it {expect(projects_members_month).to be_valid}
end
