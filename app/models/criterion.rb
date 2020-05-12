class Criterion < ApplicationRecord
  belongs_to :contest
  has_many :marks, dependent: :destroy
  validates :title, :contest, presence: true
end
