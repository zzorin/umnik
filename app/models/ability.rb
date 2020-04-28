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
        nomination_ids = Nomination.where(contest_id: contest_ids).ids
        can :manage, :spa
        can [:index, :show, :update], Contest, id: contest_ids
        can [:generate_rate_list, :generate_protocol], Contest, id: contest_ids
        can [:manage], Criterion, contest_id: contest_ids
        can [:manage], Nomination, contest_id: contest_ids
        can [:manage], Participant, nomination_id: nomination_ids
        can [:manage], Expert, contest_id: contest_ids
        can [:manage], Mark, expert_id: expert_ids
        can [:create, :destroy], Permission, context_id: expert_ids, role: 'expert'
      end

      if user.expert?
        expert_ids = user.permissions
                         .with_context
                         .where(context_type: 'Expert')
                         .map {|p| p&.context&.id}.compact
        contest_ids = Expert.where(id: expert_ids).active.pluck(:contest_id).uniq
        can :manage, :spa
        can [:index, :show], Contest, id: contest_ids
        can [:generate_rate_list, :generate_protocol], Contest, id: contest_ids, show_results: true
        can [:index], Expert, id: expert_ids
        can [:for_results], Expert, contest_id: contest_ids
        can [:index], Criterion, contest_id: contest_ids
        can [:index], Nomination, contest_id: contest_ids
        can [:index, :by_nomination, :for_results, :by_nomination_results], Participant
        can [:by_participant, :create, :update], Mark, expert_id: expert_ids
        can [:index], Mark
      end
    end
  end
end
