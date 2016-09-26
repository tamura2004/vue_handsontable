# == Schema Information
#
# Table name: works
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  month      :string
#  cost       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Work, type: :model do
  subject{build :work}
  it {should be_valid}
end
