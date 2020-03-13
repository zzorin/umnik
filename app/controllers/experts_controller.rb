class ExpertsController < ApplicationController
  load_and_authorize_resource

  def index
    @contest = Contest.find(params[:contest_id])
  end

  def show; end

  def new; end

  def edit; end

  def create
    @contest = Contest.find(params[:contest_id])
    @expert = @contest.experts.build(expert_params)
    if @expert.save
      redirect_to contest_experts_path
    else
      render 'new'
    end
  end

  def update
    if @expert.update(expert_params)
      redirect_to contest_experts_path
    else
      render 'edit'
    end
  end

  def destroy
    @expert.destroy

    redirect_to contest_experts_path
  end

  private
    def expert_params
      params.require(:expert).permit(:surname, :name, :patronymic, :contest_id)
    end
end
