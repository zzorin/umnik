class Administrator::SpaController < Administrator::ApplicationController
  authorize_resource :spa, class: false

  include Administrator::AccessRules

  def index
    @init_params = {
      user: user_init_params,
      access_rules: access_rules
    }
  end

  private

  def user_init_params
    {
      id: current_user.id
    }
  end
end
