FactoryBot.define do
  factory :contest do
    title {"Contest"}
    starts_on { DateTime.now - 1.days }
    ends_on { DateTime.now }
  end
end
