require 'rails_helper'

RSpec.describe Expert, type: :model do

  before do
    @contest = FactoryBot.create(:contest)
  end

  it "is valid with a name and contest" do
    expert = FactoryBot.build(:expert, name: "Ivanov Ivan")
    expect(expert).to be_valid
  end

  it "is invalid without a name" do
    expert = FactoryBot.build(:expert, name: nil)
    expert.valid?
    expect(expert.errors[:name]).to include("Необходимо указать имя")
  end

  it "is invalid without a contest" do
    expert = FactoryBot.build(:expert, contest_id: nil)
    expert.valid?
    expect(expert.errors[:contest]).to include("Необходимо указать конкурс")
  end

  describe "search active experts" do
    before do
      @expert1 = FactoryBot.create(:expert, name: 'expert1', active: true)
      @expert2 = FactoryBot.create(:expert, name: 'expert2', active: false)
      @expert3 = FactoryBot.create(:expert, name: 'expert3')
    end

    context "when a match is found" do
      it "creates active experts by default" do
        expect(@expert3.active).to eq true
      end
      it "returns experts with active state" do
        expect(Expert.active).to include(@expert1, @expert3)
        expect(Expert.active).to_not include(@expert2)
      end
    end

    context "when no match is found" do
      it "returns an empty collection when no active are found" do
        @expert1.update(active: false)
        @expert3.update(active: false)
        expect(Expert.active).to be_empty
      end
    end
  end
end
