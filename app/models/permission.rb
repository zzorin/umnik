# == Schema Information
#
# Table name: permissions
#
#  id           :bigint           not null, primary key
#  user_id      :string
#  role         :string
#  context_type :string
#  context_id   :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Permission < ActiveRecord::Base
  include AuthClient::Permission

  ROLES = %i(administrator university_manager expert participant).freeze

  acts_as_auth_client_permission roles: ROLES
  validates_uniqueness_of :role,
                          scope: [:user_id, :context],
                          message: 'У пользователя не может быть несколько одинаковых ролей'
  validates :user_id, presence: true

  delegate :fullname,  to: :user, allow_nil: true

  scope :with_context, -> { where.not(context_type: nil, context_id: nil) }

  def text_role
    I18n.t "permissions.#{role}"
  end
end
