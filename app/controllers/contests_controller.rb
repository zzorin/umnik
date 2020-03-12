class ContestsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def new; end

  def edit; end

  def create
    if @contest.save
      redirect_to @contest
    else
      render 'new'
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
    @contest.destroy

    redirect_to contests_path
  end

  private

    def contest_params
      params.require(:contest).permit(:title)
    end
end
