json.array! @experts do |expert|
  json.id expert.id
  json.name expert.name
  json.contest_id expert.contest_id
  json.blocked expert.active
end
