class Mark < ApplicationRecord
  belongs_to :criterion
  belongs_to :expert
  belongs_to :participant
  has_one :nomination, through: :participant

  validates :criterion, :expert, :participant, :grade, presence: true

  scope :rated, -> { where.not(grade: nil) }
end
