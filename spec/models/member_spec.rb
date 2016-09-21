require 'rails_helper'

RSpec.describe Member, type: :model do
  subject{build :member}
  it { is_expected.to be_valid }
end
