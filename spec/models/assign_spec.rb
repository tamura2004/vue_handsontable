# == Schema Information
#
# Table name: assigns
#
#  id             :integer
#  member_id      :integer
#  member_number  :string
#  member_name    :string
#  group_id       :integer
#  group_name     :string
#  job_title_id   :integer
#  job_title_name :string
#  project_id     :integer
#  project_number :string
#  project_name   :string
#  project_cost   :float
#  project_rd     :float
#  month          :string
#  cost           :float
#  member_link    :text
#  project_link   :text
#  job_title_link :text
#

require 'rails_helper'

RSpec.describe Assign, type: :model do

  context "帳票、グラフ用SQLを持つ" do
    SCOPES = %w(
      project_chart
      report_by_member
      report
    )

    SCOPES.each do |scope|
      it { expect(Assign.send(scope)).to be_a_kind_of Array }
    end
  end

end
