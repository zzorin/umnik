class NominationsController < ApplicationController
  def create
    @contest = Contest.find(params[:contest_id])
    @nomination = @contest.nominations.create(nomination_params)
    redirect_to contest_path(@contest)
  end

  def destroy
    @contest = Contest.find(params[:contest_id])
    @nomination = @contest.nominations.find(params[:id])
    @nomination.destroy
    redirect_to contest_path(@contest)
  end

  private
    def nomination_params
      params.require(:nomination).permit(:title)
    end
end
