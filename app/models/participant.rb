class Participant < ApplicationRecord
  belongs_to :nomination
  has_one :contest, through: :nomination
  has_many :marks, dependent: :destroy
  scope :ordered_by_name, -> { order('name') }
  scope :active, -> { joins(:nomination).merge(Nomination.active) }

  validates :name, :project_title, :organization,
            :contact_info, :nomination, presence: true

  def contest
    nomination.contest
  end

  def marks_sum
    self.marks.map(&:grade).compact.sum
  end

  def rated_experts
    contest.experts.rated_for_participant(self)
  end

  def rate_mark
    if rated_experts.present?
      (marks_sum / rated_experts.count.to_f).round(2)
    else
      0.00
    end
  end
end
