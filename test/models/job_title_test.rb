# == Schema Information
#
# Table name: job_titles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class JobTitleTest < ActiveSupport::TestCase
  setup do
    @job_title = JobTitle.new
  end

  test "適正である" do
    assert @job_title.valid?
  end
  
  test "名前を持つ" do
    assert_respond_to @job_title, :name
  end
end
