class Mark < ApplicationRecord
  has_paper_trail

  belongs_to :criterion
  belongs_to :expert
  belongs_to :participant
  has_one :nomination, through: :participant

  validates :criterion, :expert, :participant, presence: true
  validates :participant, uniqueness: { scope: [:criterion, :expert] }
  validates :grade, inclusion: { in: [ nil, 1, 2, 3, 4, 5 ] }

  scope :rated, -> { where.not(grade: nil) }

  def self.paper_trail_expected_fields
    %i[id criterion_id expert_id participant_id created_at updated_at]
  end
end
