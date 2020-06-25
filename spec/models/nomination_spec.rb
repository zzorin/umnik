require 'rails_helper'

RSpec.describe Nomination, type: :model do
  it "is valid with a title, code and contest" do
    nomination = FactoryBot.build(:nomination)
    expect(nomination).to be_valid
  end

  it "is invalid without a contest" do
    nomination = FactoryBot.build(:nomination, contest_id: nil)
    nomination.valid?
    expect(nomination.errors[:contest]).to include("Необходимо указать конкурс")
  end

  it "is invalid without a code" do
    nomination = FactoryBot.build(:nomination, code: nil)
    nomination.valid?
    expect(nomination.errors[:code]).to include("Необходимо указать код номинации")
  end

  it "is invalid without a title" do
    nomination = FactoryBot.build(:nomination, title: nil)
    nomination.valid?
    expect(nomination.errors[:title]).to include("Необходимо указать название номинации")
  end

  subject(:nomination) { FactoryBot.build(:nomination, code: 'code', title: 'nomination') }
  it { is_expected.to satisfy { |nomination| nomination.full_title == 'code nomination' }}
end
