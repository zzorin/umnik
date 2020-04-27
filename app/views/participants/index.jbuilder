json.array! @participants do |participant|
  json.id participant.id
  json.name participant.name
  json.organization participant.organization
  json.project_title participant.project_title
  json.project_info participant.project_info
  json.nomination do
    json.id participant.nomination_id
    json.title participant.nomination.title
  end
end
