require 'rails_helper'

RSpec.describe Group, type: :model do
  subject{build :group}
  it { is_expected.to be_valid }
end
