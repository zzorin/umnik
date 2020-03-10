class Permission < ActiveRecord::Base
  include AuthClient::Permission

  ROLES = %w(:administrator, :tusur_manager,
             :university_manager, :expert
            ).map(&:to_sym).freeze

  acts_as_auth_client_permission roles: ROLES
end
