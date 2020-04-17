class Mark < ApplicationRecord
  belongs_to :criterion
  belongs_to :expert
  belongs_to :participant
  has_one :nomination, through: :participant
end
