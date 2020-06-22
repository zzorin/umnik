# == Schema Information
#
# Table name: marks
#
#  id             :bigint           not null, primary key
#  grade          :integer
#  criterion_id   :bigint
#  expert_id      :bigint
#  participant_id :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'test_helper'

class MarkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
