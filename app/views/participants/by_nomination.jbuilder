json.array! @participants.ordered_by_name do |participant|
  json.id participant.id
  json.name participant.name
  json.organization participant.organization
  json.project_title participant.project_title
end
