@marks.each do |mark|
  json.set! mark.criterion_id do
    json.id mark.id
    json.grade mark.grade
    json.criterion_id mark.criterion_id
    json.participant_id mark.participant_id
    json.expert_id mark.expert_id
  end
end
json.marks_sum @marks.sum(&:grade)
