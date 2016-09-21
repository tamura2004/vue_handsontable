require 'rails_helper'

RSpec.describe JobTitle, type: :model do
  subject{build :job_title}
  it { is_expected.to be_valid }
end
