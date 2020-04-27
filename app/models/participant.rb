class Participant < ApplicationRecord
  belongs_to :nomination
  has_one :contest, through: :nomination
  has_many :marks
  scope :ordered_by_name, -> { order('name') }

  validates :name, :project_title, :organization,
            :contact_info, :nomination, presence: true

  def contest
    nomination.contest
  end

  def marks_sum
    self.marks.sum(&:grade)
  end

  def rate_mark
    (marks_sum / contest.experts.active.count.to_f).round(2)
  end
end
