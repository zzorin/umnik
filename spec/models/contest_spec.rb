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
require 'rails_helper'

RSpec.describe Contest, type: :model do
  it "is valid with a title, starts_on and ends_on" do
    expect(FactoryBot.build(:contest)).to be_valid
  end
  it "is invalid without a title" do
    contest = FactoryBot.build(:contest, title: nil)
    contest.valid?
    expect(contest.errors[:title]).to include("Необходимо указать название конкурса")
  end
  it "is invalid without a starts_on" do
    contest = FactoryBot.build(:contest, starts_on: nil)
    contest.valid?
    expect(contest.errors[:starts_on]).to include("Необходимо указать дату начала конкурса")
  end
  it "is invalid without an ends_on" do
    contest = FactoryBot.build(:contest, ends_on: nil)
    contest.valid?
    expect(contest.errors[:ends_on]).to include("Необходимо указать дату окончания конкурса")
  end
  it "returns active 'true' state for one day contests" do
    contest = FactoryBot.build(:contest, starts_on: DateTime.now)
    expect(contest).to be_active
  end
  it "returns active 'false' state for past contests" do
    contest = FactoryBot.build(:contest, :inactive)
    expect(contest).not_to be_active
  end
end
