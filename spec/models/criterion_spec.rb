require 'rails_helper'

RSpec.describe Criterion, type: :model do
  it "is valid with a title and contest" do
    contest = Contest.create(
      title: "Contest",
      starts_on: DateTime.now - 1.days,
      ends_on: DateTime.now
    )
    criterion = contest.criterions.new(title: "Criterion")
    expect(criterion).to be_valid
  end
  it "is invalid without a title" do
    contest = Contest.create(
      title: "Contest",
      starts_on: DateTime.now - 1.days,
      ends_on: DateTime.now
    )
    criterion = contest.criterions.new(title: nil)
    criterion.valid?
    expect(criterion.errors[:title]).to include("Необходимо указать название критерия")
  end
  it "is invalid without a contest" do
    criterion = Criterion.new(contest_id: nil)
    criterion.valid?
    expect(criterion.errors[:contest]).to include("Необходимо указать конкурс")
  end
end
