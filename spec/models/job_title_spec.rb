# == Schema Information
#
# Table name: job_titles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe JobTitle, type: :model do
  subject{build :job_title}
  it { is_expected.to be_valid }
end
