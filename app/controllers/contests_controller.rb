class ContestsController < ApplicationController
  def index
    @contests = Contest.all
  end

  def show
    @contest = Contest.find(params[:id])
  end

  def new
    @contest = Contest.new
  end

  def edit
    @contest = Contest.find(params[:id])
  end

  def create
    @contest = Contest.new(contest_params)

    if @contest.save
      redirect_to @contest
    else
      render 'new'
    end
  end

  def update
    @contest = Contest.find(params[:id])

    if @contest.update(contest_params)
      redirect_to @contest
    else
      render 'edit'
    end
  end

  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy

    redirect_to contests_path
  end

  private

    def contest_params
      params.require(:contest).permit(:title)
    end
end
