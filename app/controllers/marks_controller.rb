class MarksController < ApplicationController
  load_and_authorize_resource

  def index
    @contest = Contest.find(params[:contest_id])
    @participants = @contest.participants
    @experts = @contest.experts.active
    @criterions = @contest.criterions
  end

  def by_participant
    @marks = Mark.where(participant_id: params[:participant_id],
                        expert_id: params[:expert_id]
                      )
  end

  def create
    @mark = Mark.new(mark_params)
    if @mark.save
      render :create
    else
      render :errors
    end
  end

  def update
    if @mark.update(mark_params)
      render :update
    else
      render :errors
    end
  end

  private

  def mark_params
    params.require(:mark).permit(:grade, :participant_id, :expert_id, :criterion_id)
  end
end
