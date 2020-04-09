class CriterionsController < ApplicationController
  load_and_authorize_resource

  def index
    @contest = Contest.find(params[:contest_id])
    @criterions = @contest.criterions
  end

  def show; end

  def new; end

  def edit; end

  def create
    @contest = Contest.find(params[:contest_id])
    @criterion = @contest.criterions.build(criterion_params)
    if @criterion.save
      render :create
    else
      render :errors
    end
  end

  def update
    if @criterion.update(criterion_params)
      render :update
    else
      render :errors
    end
  end

  def destroy
    if @criterion.destroy
      render :destroy
    else
      render :errors
    end
  end

  private
    def criterion_params
      params.require(:criterion).permit(:title, :contest_id)
    end
end
