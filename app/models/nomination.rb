# == Schema Information
#
# Table name: nominations
#
#  id         :bigint           not null, primary key
#  title      :string
#  contest_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string
#  active     :boolean          default("true")
#
class Nomination < ApplicationRecord
  belongs_to :contest
  has_many :participants, dependent: :destroy
  has_many :marks, through: :participants
  scope :active, -> { where(active: true) }

  validates :code, :title, :contest, presence: true

  def full_title
    code + ' ' + title
  end
end
