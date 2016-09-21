require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project){FactoryGirl.build(:project)}
  it {expect(project).to be_valid}
end
