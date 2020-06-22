# == Schema Information
#
# Table name: criterions
#
#  id         :bigint           not null, primary key
#  title      :string
#  contest_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :criterion do
    title {"Criterion"}
    association :contest
  end
end
