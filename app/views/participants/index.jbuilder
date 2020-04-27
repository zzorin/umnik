json.array! @participants.sort_by {|p| p.rate_mark }.reverse do |participant|
  json.id participant.id
  json.name participant.name
  json.organization participant.organization
  json.project_title participant.project_title
  json.nomination do
    json.id participant.nomination_id
    json.title participant.nomination.title
  end
end
