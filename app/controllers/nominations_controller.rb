class NominationsController < ApplicationController
  load_and_authorize_resource

  def index
    @contest = Contest.find(params[:contest_id])
    @nominations = @contest.nominations
  end

  def create
    if @nomination.save
      render :create
    else
      render :errors
    end
  end

  def update
    if @nomination.update(nomination_params)
      render :update
    else
      render :errors
    end
  end

  def destroy
    if @nomination.destroy
      render :destroy
    else
      render :errors
    end
  end

  private
    def nomination_params
      params.require(:nomination).permit(:code, :title, :contest_id, :active)
    end
end
