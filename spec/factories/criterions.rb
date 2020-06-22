FactoryBot.define do
  factory :criterion do
    title {"Criterion"}
    association :contest
  end
end
