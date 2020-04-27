class Expert < ApplicationRecord
  belongs_to :contest
  has_many :marks, dependent: :destroy
  has_one :permission, as: :context, dependent: :destroy
  validates :name, :contest, presence: true
  validates :active, inclusion: { in: [ true, false ] }
  scope :active, -> { where(active: true) }
  scope :rated_for_participant, ->(participant) do
    active.joins(:marks).where(marks: {participant_id: participant.id})
  end

  def user
    permission&.user
  end
end
