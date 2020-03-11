class Permission < ActiveRecord::Base
  include AuthClient::Permission

  ROLES = %i(administrator tusur_manager
             university_manager expert
            ).freeze

  acts_as_auth_client_permission roles: ROLES

  delegate :fullname,  to: :user, allow_nil: true
end
