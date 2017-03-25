require 'rails_helper'

RSpec.describe Assign, type: :model do
  it{ expect(Assign.project_chart).to be_a_kind_of Array }
  it{ expect(Assign.report_by_member).to be_a_kind_of Array }
  it{ expect(Assign.report).to be_a_kind_of Array }
end
