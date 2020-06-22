FactoryBot.define do
  factory :nomination do
    code { "N1" }
    title { "Nomination" }

    trait :with_participant do
      after(:create) { |nomination| create_list(:participant, 1, nomination: nomination) }
    end
  end
end
