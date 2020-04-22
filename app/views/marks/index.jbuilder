@participants.each do |participant|
  json.set! participant.id do
    @experts.each do |expert|
      json.set! expert.id do
        @criterions.each do |criterion|
          json.set! criterion.id do
            mark = Mark.find_by(participant_id: participant.id,
                                expert_id: expert.id,
                                criterion_id: criterion.id)
            json.grade mark.present? ? mark.grade : 0
          end
        end

      end
    end
    json.marks_sum participant.marks.sum(&:grade)
  end
end
