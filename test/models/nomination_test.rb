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
require 'test_helper'

class NominationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
