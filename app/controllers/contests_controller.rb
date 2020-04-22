class ContestsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def create
    if @contest.save
      render :create
    else
      render :errors
    end
  end

  def update
    if @contest.update(contest_params)
      redirect_to @contest
    else
      render 'edit'
    end
  end

  def destroy
    if @contest.destroy
      render :destroy
    else
      render :errors
    end
  end

  private

    def contest_params
      params.require(:contest).permit(:title, :starts_on, :ends_on)
    end
end
