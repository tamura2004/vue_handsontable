# == Schema Information
#
# Table name: projects_members_months
#
#  id                 :integer          not null, primary key
#  projects_member_id :integer
#  month              :string
#  cost               :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class ProjectsMembersMonthTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
