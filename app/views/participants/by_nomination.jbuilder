json.array! @participants do |participant|
  json.id participant.id
  json.name participant.name
  json.organization participant.organization
  json.project_title participant.project_title
end
