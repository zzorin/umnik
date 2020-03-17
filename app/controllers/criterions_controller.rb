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
      redirect_to contest_criterions_path
    else
      render 'new'
    end
  end

  def update
    if @criterion.update(criterion_params)
      redirect_to contest_criterions_path
    else
      render 'edit'
    end
  end

  def destroy
    @criterion.destroy

    redirect_to contest_criterions_path
  end

  private
    def criterion_params
      params.require(:criterion).permit(:title, :contest_id)
    end
end
