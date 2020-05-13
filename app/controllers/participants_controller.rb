class ParticipantsController < ApplicationController
  load_and_authorize_resource

  def index
    @contest = Contest.find(params[:contest_id])
    @participants = if params[:active] == 'true'
      @contest.participants.active.accessible_by(current_ability)
    else
      @contest.participants.accessible_by(current_ability)
    end
    @participants = Kaminari.paginate_array(@participants.ordered_by_name)
                         .page(params[:page])
                         .per(8)
  end

  def for_results
    @contest = Contest.find(params[:contest_id])
    @participants = @contest.participants
  end

  def show; end

  def create
    if @participant.save
      render :create
    else
      render :errors
    end
  end

  def update
    if @participant.update(participant_params)
      render :update
    else
      render :errors
    end
  end

  def destroy
    if @participant.destroy
      render :destroy
    else
      render :errors
    end
  end

  def by_nomination
    @nomination = Nomination.find(params[:nomination_id])
    @participants = @nomination.participants
  end

  def by_nomination_results
    @nomination = Nomination.find(params[:nomination_id])
    @participants = @nomination.participants
  end

  private
    def participant_params
      params.require(:participant)
            .permit(:name, :organization, :project_title,
                    :contact_info, :nomination_id, :chat_link)
    end
end
