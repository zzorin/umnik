class Nomination < ApplicationRecord
  belongs_to :contest
  has_many :participants, dependent: :destroy
  has_many :marks, through: :participants
  scope :active, -> { where(active: true) }

  validates :code, :title, :contest, presence: true

  def full_title
    code + ' ' + title
  end
end
