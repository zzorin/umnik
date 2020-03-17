class Expert < ApplicationRecord
  belongs_to :contest
  has_many :marks
  validates :surname, :name, presence: true

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
