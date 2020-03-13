class Nomination < ApplicationRecord
  belongs_to :contest
  has_many :participants
end
