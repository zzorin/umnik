class Expert < ApplicationRecord
  belongs_to :contest
  has_many :marks, dependent: :destroy
  has_one :permission, as: :context, dependent: :destroy
  validates :name, :contest, presence: true
  validates :active, inclusion: { in: [ true, false ] }
  scope :active, -> { where(active: true) }

  def user
    permission&.user
  end
end
