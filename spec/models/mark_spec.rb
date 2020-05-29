require 'rails_helper'

RSpec.describe Mark, type: :model do
  before do
    @contest = Contest.create(
      title: "Contest",
      starts_on: DateTime.now - 1.days,
      ends_on: DateTime.now
    )
    @expert = @contest.experts.create(name: "Ivanov Ivan")
    @criterion = @contest.criterions.create(title: "Criterion")
    @nomination = @contest.nominations.create(
      code: "N1",
      title: "Nomination"
    )
    @participant = @nomination.participants.create(
      name: 'Participant',
      project_title: 'project_title',
      organization: 'organization',
      contact_info: 'contact_info'
    )
  end

  it "is valid with an expert, criterion and participant" do
    mark = Mark.new(
      expert: @expert,
      criterion: @criterion,
      participant: @participant
    )
    expect(mark).to be_valid
  end

  it "is invalid without an expert" do
    mark = Mark.new(
      expert: nil,
      criterion: @criterion,
      participant: @participant
    )
    mark.valid?
    expect(mark.errors[:expert]).to include("не может быть пустым")
  end

  it "is invalid without a criterion" do
    mark = Mark.new(
      expert: @expert,
      criterion: nil,
      participant: @participant
    )
    mark.valid?
    expect(mark.errors[:criterion]).to include("не может быть пустым")
  end

  it "is invalid without a participant" do
    mark = Mark.new(
      expert: @expert,
      criterion: @criterion,
      participant: nil
    )
    mark.valid?
    expect(mark.errors[:participant]).to include("не может быть пустым")
  end

  it "is valid with empty grade" do
    mark = Mark.new(
      expert: @expert,
      criterion: @criterion,
      participant: @participant,
      grade: nil
    )
    expect(mark).to be_valid
  end

  it "is valid with grade equals 1" do
    mark = Mark.new(
      expert: @expert,
      criterion: @criterion,
      participant: @participant,
      grade: 1
    )
    expect(mark).to be_valid
  end

  it "is valid with grade equals 5" do
    mark = Mark.new(
      expert: @expert,
      criterion: @criterion,
      participant: @participant,
      grade: 5
    )
    expect(mark).to be_valid
  end

  it "is valid with grade less than 1" do
    mark = Mark.new(
      expert: @expert,
      criterion: @criterion,
      participant: @participant,
      grade: 0
    )
    mark.valid?
    expect(mark.errors[:grade]).to include("имеет непредусмотренное значение")
  end

  it "is valid with grade more than 5" do
    mark = Mark.new(
      expert: @expert,
      criterion: @criterion,
      participant: @participant,
      grade: 6
    )
    mark.valid?
    expect(mark.errors[:grade]).to include("имеет непредусмотренное значение")
  end

  it "does not allow dublicate mark expert and criterion per participant" do
    @participant.marks.create(
      expert: @expert,
      criterion: @criterion
    )
    mark = @participant.marks.new(
      expert: @expert,
      criterion: @criterion
    )
    mark.valid?
    expect(mark.errors[:participant]).to include("уже существует")
  end

  describe "search rated marks" do
    before do
      criterion1 = @contest.criterions.create(title: "Criterion1")
      criterion2 = @contest.criterions.create(title: "Criterion2")
      criterion3 = @contest.criterions.create(title: "Criterion3")
      @mark1 = criterion1.marks.create(
        expert: @expert,
        participant: @participant,
        grade: nil
      )
      @mark2 = criterion2.marks.create(
        expert: @expert,
        participant: @participant,
        grade: 1
      )
      @mark3 = criterion3.marks.create(
        expert: @expert,
        participant: @participant,
        grade: 2
      )
    end

    context "when a match is found" do
      it "returns rated marks" do
        expect(Mark.rated).to include(@mark2, @mark3)
        expect(Mark.rated).to_not include(@mark1)
      end
    end

    context "when no match is found" do
      it "returns an empty collection when no rated marks found" do
        @mark2.update(grade: nil)
        @mark3.update(grade: nil)
        expect(Mark.rated).to be_empty
      end
    end
  end
end
