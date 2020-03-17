class MarksController < ApplicationController
  load_and_authorize_resource
  def index
    @contest = Contest.find(params[:contest_id])
    # @expert = Expert.find(params[:expert_id])
  end
end
