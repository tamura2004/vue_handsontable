# == Schema Information
#
# Table name: v_members
#
#  id             :integer
#  member_number  :string
#  member_name    :string
#  group_id       :integer
#  group_name     :string
#  job_title_id   :integer
#  job_title_name :string
#  member_link    :text
#  job_title_link :text
#  group_link     :text
#

require 'rails_helper'

RSpec.describe VMember, type: :model do
  it{expect(VMember.all).to eq []}
end
