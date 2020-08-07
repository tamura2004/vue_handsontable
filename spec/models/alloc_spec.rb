# == Schema Information
#
# Table name: allocs
#
#  id         :integer          not null, primary key
#  assign_id  :integer
#  month      :string
#  cost       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Alloc, type: :model do
  subject{build :alloc}
  it {should be_valid}
end
