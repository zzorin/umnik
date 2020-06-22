require 'rails_helper'

RSpec.describe Participant, type: :model do
  it "is valid with a name, project_title, organization, contact_info, nomination" do
    participant = FactoryBot.build(:participant)
    expect(participant).to be_valid
  end

  it "is invalid without a nomination" do
    participant = FactoryBot.build(:participant, nomination_id: nil)
    participant.valid?
    expect(participant.errors[:nomination]).to include("Необходимо выбрать номинацию")
  end

  it "is invalid without a name" do
    participant = FactoryBot.build(:participant, name: nil)
    participant.valid?
    expect(participant.errors[:name]).to include("Необходимо указать имя")
  end

  it "is invalid without a project_title" do
    participant = FactoryBot.build(:participant, project_title: nil)
    participant.valid?
    expect(participant.errors[:project_title]).to include("Необходимо указать название доклада")
  end

  it "is invalid without a organization" do
    participant = FactoryBot.build(:participant, organization: nil)
    participant.valid?
    expect(participant.errors[:organization]).to include("Необходимо указать организацию")
  end

  it "is invalid without a contact_info" do
    participant = FactoryBot.build(:participant, contact_info: nil)
    participant.valid?
    expect(participant.errors[:contact_info]).to include("Необходимо указать контактные данные")
  end

  describe "search active participants" do
    before do
      @default_nomination = FactoryBot.create(:nomination)
      @active_nomination = FactoryBot.create(:nomination, active: true)
      @inactive_nomination = FactoryBot.create(:nomination, active: false)
      @participant1 = FactoryBot.create(:participant, name: 'participant1', nomination_id: @active_nomination.id)
      @participant2 = FactoryBot.create(:participant, name: 'participant2', nomination_id: @inactive_nomination.id)
      @participant3 = FactoryBot.create(:participant, name: 'participant3', nomination_id: @default_nomination.id)
    end

    context "when a match is found" do
      it "returns participants with active state" do
        expect(Participant.active).to include(@participant1, @participant3)
        expect(Participant.active).to_not include(@participant2)
      end
    end

    context "when no match is found" do
      it "returns an empty collection when no active are found" do
        @default_nomination.update(active: false)
        @active_nomination.update(active: false)
        expect(Participant.active).to be_empty
      end
    end
  end
end
