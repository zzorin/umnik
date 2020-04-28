class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_paper_trail_whodunnit

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
