# == Schema Information
#
# Table name: members
#
#  id           :integer          not null, primary key
#  name         :string
#  group_id     :integer
#  job_title_id :integer
#  number       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Member, type: :model do
  subject{build :member}
  it { is_expected.to be_valid }
end
