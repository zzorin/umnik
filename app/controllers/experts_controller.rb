class ExpertsController < ApplicationController
  load_and_authorize_resource

  def index
    @contest = Contest.find(params[:contest_id])
    @experts = @contest.experts
  end

  def show; end

  def create
    @contest = Contest.find(params[:contest_id])
    @expert = @contest.experts.build(expert_params)
    if @expert.save
      render :create
    else
      render :errors
    end
  end

  def update
    if @expert.update(expert_params)
      render :update
    else
      render :errors
    end
  end

  def destroy
    if @expert.destroy
      render :destroy
    else
      render :errors
    end
  end

  private
    def expert_params
      params.require(:expert).permit(:surname, :name, :patronymic, :contest_id)
    end
end
