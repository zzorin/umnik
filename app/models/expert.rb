class Expert < ApplicationRecord
  belongs_to :contest
  has_many :marks, dependent: :destroy
  has_one :permission, as: :context, dependent: :destroy
  validates :surname, :name, presence: true

  def fullname
    [surname, name, patronymic].compact.join(' ')
  end

  def user
    permission&.user
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
