class Api::V1::ContestsController < Api::V1::ApplicationController
  def all
    @contests = Contest.all
  end
end
