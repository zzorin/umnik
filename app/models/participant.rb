class Participant < ApplicationRecord
  belongs_to :nomination

  validates :surname, :name, :project_title, :project_info, :organization,
            :contact_info, :nomination, presence: true

  def contest
    nomination.contest
  end
end
