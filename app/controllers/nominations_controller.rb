class NominationsController < ApplicationController
  load_and_authorize_resource

  def index
    @contest = Contest.find(params[:contest_id])
    @nominations = @contest.nominations
  end

  def show; end

  def new; end

  def edit; end

  def create
    @contest = Contest.find(params[:contest_id])
    @nomination = @contest.nominations.build(nomination_params)
    if @nomination.save
      redirect_to contest_nominations_path
    else
      render 'new'
    end
  end

  def update
    if @nomination.update(nomination_params)
      redirect_to contest_nominations_path
    else
      render 'edit'
    end
  end

  def destroy
    @nomination.destroy

    redirect_to contest_nominations_path
  end

  private
    def nomination_params
      params.require(:nomination).permit(:title, :contest_id)
    end
end
