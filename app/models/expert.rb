class Expert < ApplicationRecord
  belongs_to :contest

  validates :surname, :name, presence: true
end
