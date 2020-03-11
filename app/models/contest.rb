class Contest < ApplicationRecord
  has_many :nominations, dependent: :destroy
  validates :title, presence: true
end
