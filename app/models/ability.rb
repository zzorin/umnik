# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.administrator?
      can :manage, :all
    end

    if user.tusur_manager?
      can :manage, [Contest, Nomination]
    end

    if user.university_manager?
    end

    if user.expert?
    end
  end
end
