# == Schema Information
#
# Table name: experts
#
#  id         :bigint           not null, primary key
#  surname    :string
#  name       :string
#  patronymic :string
#  contest_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  active     :boolean          default("true")
#
FactoryBot.define do
  factory :expert do
    name {"Ivanov Ivan"}
    association :contest
  end
end
