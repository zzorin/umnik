require 'rails_helper'

RSpec.describe Criterion, type: :model do
  it "is valid with a title and contest" do
    criterion = FactoryBot.build(:criterion, title: "Criterion")
    expect(criterion).to be_valid
  end
  it "is invalid without a title" do
    criterion = FactoryBot.build(:criterion, title: nil)
    criterion.valid?
    expect(criterion.errors[:title]).to include("Необходимо указать название критерия")
  end
  it "is invalid without a contest" do
    criterion = FactoryBot.build(:criterion, contest_id: nil)
    criterion.valid?
    expect(criterion.errors[:contest]).to include("Необходимо указать конкурс")
  end
end
