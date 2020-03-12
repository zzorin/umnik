class Contest < ApplicationRecord
  has_many :nominations, dependent: :destroy
  has_many :criterions, dependent: :destroy
  validates :title, presence: true
end
