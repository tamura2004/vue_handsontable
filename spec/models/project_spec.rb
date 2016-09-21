require 'rails_helper'

RSpec.describe Project, type: :model do
  subject{build :project}
  it { is_expected.to be_valid }
end
