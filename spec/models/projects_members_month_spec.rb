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

require 'rails_helper'

RSpec.describe ProjectsMembersMonth, type: :model do
  subject{build :projects_members_month}
  it {should be_valid}
end
