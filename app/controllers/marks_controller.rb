class MarksController < ApplicationController
  load_and_authorize_resource
  def by_participant
    @marks = Mark.where(participant_id: params[:participant_id],
                        expert_id: params[:expert_id]
                      )
  end
end
