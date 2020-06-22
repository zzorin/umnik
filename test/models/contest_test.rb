# == Schema Information
#
# Table name: contests
#
#  id           :bigint           not null, primary key
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  starts_on    :datetime
#  ends_on      :datetime
#  show_results :boolean          default("false")
#
require 'test_helper'

class ContestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
