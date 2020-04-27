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
      render :update
    else
      render :errors
    end
  end

  def destroy
    if @contest.destroy
      render :destroy
    else
      render :errors
    end
  end

  def generate_rate_list
    if params[:nomination_id].present? && params[:nomination_id] != 'all'
      report = Statistic::NominationRateList.
        new(params[:contest_id], params[:nomination_id]).
        generate
      send_data report.to_stream.read,
        filename: "nomination_rate_list.xlsx",
        type: 'application/vnd.openxmlformates-officedocument.spreadsheetml.sheet'
    else
      report = Statistic::RateList.new(params[:contest_id]).generate
      send_data report.to_stream.read,
        filename: "rate_list.xlsx",
        type: 'application/vnd.openxmlformates-officedocument.spreadsheetml.sheet'
    end
  end

  def generate_protocol
    report = Statistic::Protocol.new(params[:contest_id], params[:nomination_id]).generate
    send_data report.to_stream.read,
      filename: "protocol.xlsx",
      type: 'application/vnd.openxmlformates-officedocument.spreadsheetml.sheet'
  end

  private

    def contest_params
      params.require(:contest).permit(:title, :starts_on, :ends_on)
    end
end
