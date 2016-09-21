require 'rails_helper'

RSpec.describe ProjectsMember, type: :model do
  subject{build :projects_member}
  it { is_expected.to be_valid }
end
