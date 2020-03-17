class ParticipantsController < ApplicationController
  load_and_authorize_resource

  def index
    @contest = Contest.find(params[:contest_id])
    @participants = @contest.participants
  end

  def show; end

  def new; end

  def edit; end

  def create
    @contest = Contest.find(params[:contest_id])
    if @participant.save
      redirect_to contest_participants_path
    else
      render 'new'
    end
  end

  def update
    if @participant.update(participant_params)
      redirect_to contest_participants_path
    else
      render 'edit'
    end
  end

  def destroy
    @participant.destroy

    redirect_to contest_participants_path
  end

  private
    def participant_params
      params.require(:participant)
            .permit(:surname, :name, :patronymic, :organization, :project_title,
                    :project_info, :contact_info, :nomination_id)
    end
end
