class Contest < ApplicationRecord
  has_many :nominations, dependent: :destroy
  has_many :criterions, dependent: :destroy
  has_many :experts, dependent: :destroy
  has_many :participants, through: :nominations
  validates :title, :starts_on, :ends_on, presence: true

  def active?
    Time.zone.now < ends_on && Time.zone.now > starts_on
  end
end
