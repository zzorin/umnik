# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.administrator?
        can :manage, :all
      end

      if user.university_manager?
        contest_ids = user.permissions
                         .with_context
                         .where(context_type: 'Contest')
                         .map {|p| p&.context&.id}.compact
        expert_ids = Expert.where(contest_id: contest_ids).ids
        can :manage, :spa
        can [:index, :show, :update], Contest, id: contest_ids
        can [:manage], Expert, id: contest_ids
        can [:manage], Criterion, contest_id: contest_ids
        can [:manage], Nomination, contest_id: contest_ids
        can [:manage], Participant, contest_id: contest_ids
        can [:manage], Expert, contest_id: contest_ids
        can [:manage], Mark, expert_id: expert_ids
      end

      if user.expert?
        expert_ids = user.permissions
                         .with_context
                         .where(context_type: 'Expert')
                         .map {|p| p&.context&.id}.compact
        contest_ids = Expert.where(id: expert_ids).pluck(:contest_id).uniq
        can :manage, :spa
        can [:index, :show], Contest, id: contest_ids
        can [:index], Expert, id: expert_ids
        can [:index], Criterion, contest_id: contest_ids
        can [:index], Nomination, contest_id: contest_ids
        can [:index, :by_nomination], Participant
        can [:by_participant, :create, :update], Mark, expert_id: expert_ids
      end
    end
  end
end
