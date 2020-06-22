# == Schema Information
#
# Table name: criterions
#
#  id         :bigint           not null, primary key
#  title      :string
#  contest_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Criterion < ApplicationRecord
  belongs_to :contest
  has_many :marks, dependent: :destroy
  validates :title, :contest, presence: true
end
