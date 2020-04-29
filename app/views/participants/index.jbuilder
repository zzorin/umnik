json.array! @participants.ordered_by_name do |participant|
  json.id participant.id
  json.name participant.name
  json.organization participant.organization
  json.project_title participant.project_title
  json.chat_link participant.chat_link
  json.nomination do
    json.id participant.nomination_id
    json.title participant.nomination.title
  end
end
