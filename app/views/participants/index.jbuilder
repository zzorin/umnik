json.array! @participants do |participant|
  json.id participant.id
  json.surname participant.surname
  json.name participant.name
  json.patronymic participant.patronymic
  json.fullname participant.fullname
  json.shortname participant.shortname
  json.organization participant.organization
  json.project_title participant.project_title
  json.project_info participant.project_info
  json.nomination do
    json.id participant.nomination_id
    json.title participant.nomination.title
  end
end
