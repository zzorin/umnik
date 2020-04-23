class Criterion < ApplicationRecord
  belongs_to :contest
  validates :title, :contest, presence: true
end
