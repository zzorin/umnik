class ResultsController < ApplicationController
  # load_and_authorize_resource

  def generate_rate_list
    report = Statistic::RateList.new(params[:contest_id], params[:nomination_id]).generate
    send_data report.to_stream.read,
      filename: "rate_list.xlsx",
      type: 'application/vnd.openxmlformates-officedocument.spreadsheetml.sheet'
  end

  def generate_protocol
  end
end
