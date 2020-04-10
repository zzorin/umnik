json.array! @experts do |expert|
  json.id expert.id
  json.surname expert.surname
  json.name expert.name
  json.patronymic expert.patronymic
  json.shortname expert.shortname
  json.contest_id expert.contest_id
end
