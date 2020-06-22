# == Schema Information
#
# Table name: experts
#
#  id         :bigint           not null, primary key
#  surname    :string
#  name       :string
#  patronymic :string
#  contest_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  active     :boolean          default("true")
#
require 'test_helper'

class ExpertTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
