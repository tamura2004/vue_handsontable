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

require 'rails_helper'

RSpec.describe Assign, type: :model do
  subject { build :assign }
  it { should be_valid }
end
