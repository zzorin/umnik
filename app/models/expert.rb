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
class Expert < ApplicationRecord
  belongs_to :contest
  has_many :marks, dependent: :destroy
  has_one :permission, as: :context, dependent: :destroy
  validates :name, :contest, presence: true
  validates :active, inclusion: { in: [ true, false ] }
  scope :active, -> { where(active: true) }
  scope :rated_for_participant, ->(participant) do
    active.joins(:marks).merge(Mark.rated).where(marks: {participant_id: participant.id}).uniq
  end

  def user
    permission&.user
  end
end
