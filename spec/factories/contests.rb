# == Schema Information
#
# Table name: contests
#
#  id           :bigint           not null, primary key
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  starts_on    :datetime
#  ends_on      :datetime
#  show_results :boolean          default("false")
#
FactoryBot.define do
  factory :contest do
    title {"Contest"}
    starts_on { DateTime.now - 1.days }
    ends_on { DateTime.now }
  end
end
