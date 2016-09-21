require 'rails_helper'

RSpec.describe ProjectsMembersMonth, type: :model do
  subject{build :projects_members_month}
  it { is_expected.to be_valid }
end
