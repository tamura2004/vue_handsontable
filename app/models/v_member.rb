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

class VMember < ApplicationRecord
end
