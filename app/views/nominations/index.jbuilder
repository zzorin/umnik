json.array! @nominations do |nomination|
  json.id nomination.id
  json.code nomination.code
  json.title nomination.title
  json.active nomination.active
  json.contest_id nomination.contest_id
end
