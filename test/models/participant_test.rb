# == Schema Information
#
# Table name: participants
#
#  id            :bigint           not null, primary key
#  surname       :string
#  name          :string
#  patronymic    :string
#  project_title :string
#  project_info  :text
#  organization  :string
#  contact_info  :string
#  nomination_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  chat_link     :string
#
require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
