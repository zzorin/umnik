class Nomination < ApplicationRecord
  belongs_to :contest
  has_many :participants
  has_many :marks, through: :participants
end
