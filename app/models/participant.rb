class Participant < ApplicationRecord
  belongs_to :nomination
  has_many :marks

  validates :name, :project_title, :organization,
            :contact_info, :nomination, presence: true

  def contest
    nomination.contest
  end
end
