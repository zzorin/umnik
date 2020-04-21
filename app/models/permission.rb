class Permission < ActiveRecord::Base
  include AuthClient::Permission

  ROLES = %i(administrator university_manager expert).freeze

  acts_as_auth_client_permission roles: ROLES

  delegate :fullname,  to: :user, allow_nil: true

  scope :with_context, -> { where.not(context_type: nil, context_id: nil) }

  def text_role
    I18n.t "permissions.#{role}"
  end
end
