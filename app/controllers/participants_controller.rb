class ParticipantsController < ApplicationController
  load_and_authorize_resource

  def index
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

  private
    def participant_params
      params.require(:participant)
            .permit(:name, :organization, :project_title,
                    :contact_info, :nomination_id)
    end
end
