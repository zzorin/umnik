FactoryBot.define do
  factory :expert do
    name {"Ivanov Ivan"}
    association :contest
  end
end
