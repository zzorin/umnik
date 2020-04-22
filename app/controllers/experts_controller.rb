class ExpertsController < ApplicationController
  load_and_authorize_resource

  def index
    @contest = Contest.find(params[:contest_id])
    @experts = @contest.experts.accessible_by(current_ability)
  end

  def show; end

  def create
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
      params.require(:expert).permit(:surname, :name, :patronymic, :contest_id, :active)
    end
end
