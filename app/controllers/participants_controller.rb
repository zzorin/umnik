class ParticipantsController < ApplicationController
  load_and_authorize_resource

  def index
    @contest = Contest.find(params[:contest_id])
    @participants = @contest.participants
  end

  def show; end

  def create
    @contest = Contest.find(params[:contest_id])
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

  private
    def participant_params
      params.require(:participant)
            .permit(:surname, :name, :patronymic, :organization, :project_title,
                    :project_info, :contact_info, :nomination_id)
    end
end
