require 'rails_helper'

describe PlanDecorator do
  let(:member) { create(:member).decorate }

  it {
    expect(member.member_name).to eq(member.name)
  }
end
