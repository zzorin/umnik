class Participant < ApplicationRecord
  belongs_to :nomination
  has_many :marks

  validates :surname, :name, :project_title, :project_info, :organization,
            :contact_info, :nomination, presence: true

  def contest
    nomination.contest
  end

  def fullname
    [surname, name, patronymic].compact.join(' ')
  end

  def shortname
    result = [surname]
    str = ''
    str += %(#{name&.at(0)}.) if name.present?
    str += %(#{patronymic&.at(0)}.) if patronymic.present?
    result << str

    result.compact.join(' ').squish
  end
end
