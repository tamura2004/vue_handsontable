FactoryGirl.define do
  factory :member do
    number {rand(1000000)}
    name {Faker::Name.name}
    association :group
    association :job_title
  end
end
