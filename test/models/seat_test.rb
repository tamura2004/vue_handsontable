# == Schema Information
#
# Table name: seats
#
#  id         :integer          not null, primary key
#  job        :string
#  name       :string
#  state_id   :integer
#  col        :integer
#  row        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class SeatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
