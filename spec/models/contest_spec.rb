require 'rails_helper'

RSpec.describe Contest, type: :model do
  it "is valid with a title, starts_on and ends_on" do
    expect(FactoryBot.build(:contest)).to be_valid
  end
  it "is invalid without a title" do
    contest = Contest.new(title: nil)
    contest.valid?
    expect(contest.errors[:title]).to include("Необходимо указать название конкурса")
  end
  it "is invalid without a starts_on" do
    contest = Contest.new(starts_on: nil)
    contest.valid?
    expect(contest.errors[:starts_on]).to include("Необходимо указать дату начала конкурса")
  end
  it "is invalid without an ends_on" do
    contest = Contest.new(ends_on: nil)
    contest.valid?
    expect(contest.errors[:ends_on]).to include("Необходимо указать дату окончания конкурса")
  end
  it "returns active 'true' state for one day contests" do
    contest = Contest.new(
      title: "Contest",
      starts_on: DateTime.now,
      ends_on: DateTime.now
    )
    expect(contest.active?).to eq true
  end
  it "returns active 'false' state for past contests" do
    contest = Contest.new(
      title: "Contest",
      starts_on: DateTime.now-2.days,
      ends_on: DateTime.now-1.days
    )
    expect(contest.active?).to eq false
  end
end
