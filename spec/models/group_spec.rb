# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  department_id :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Group, type: :model do
  subject{build :group}
  it { is_expected.to be_valid }
end
