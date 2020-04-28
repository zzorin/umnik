Permission.available_roles.each do |role|
  json.set! role do
    json.title I18n.t("permissions.#{role}")
    if role == 'university_manager'
      json.context_type 'Contest'
      json.contexts do
        json.array! Contest.all do |contest|
          json.context_id contest.id
          json.title contest.title
        end
      end
    end
    if role == 'expert'
      json.context_type 'Expert'
      json.contexts do
        json.array! Expert.all do |expert|
          json.context_id expert.id
          json.title expert.name + '-'+ expert.contest.title
        end
      end
    end
    if role == 'participant'
      json.context_type 'Participant'
      json.contexts do
        json.array! Participant.all do |participant|
          json.context_id participant.id
          json.title participant.name + '-'+ participant.contest.title
        end
      end
    end
  end
end
