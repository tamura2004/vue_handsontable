require 'rails_helper'

RSpec.describe Department, type: :model do
  subject{build :department}
  it { is_expected.to be_valid }
end
