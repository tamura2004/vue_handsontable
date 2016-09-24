# == Schema Information
#
# Table name: projects_members
#
#  id         :integer          not null, primary key
#  project_id :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ProjectsMemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
