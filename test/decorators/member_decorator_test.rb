require 'test_helper'

class MemberDecoratorTest < ActiveSupport::TestCase
  def setup
    @member = Member.new.extend MemberDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
