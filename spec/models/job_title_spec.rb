require 'rails_helper'

RSpec.describe JobTitle, type: :model do
  let(:job_title){FactoryGirl.build(:job_title)}
  it {expect(job_title).to be_valid}
end
