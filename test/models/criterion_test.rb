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
require 'test_helper'

class CriterionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
