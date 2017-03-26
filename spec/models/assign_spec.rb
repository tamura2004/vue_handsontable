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
