json.array! @contests do |contest|
  json.id contest.id
  json.title contest.title
  json.starts_on contest.starts_on
  json.ends_on contest.ends_on
  json.show_results contest.show_results
  json.is_active contest.active?
  json.starts_on_format contest.starts_on&.strftime('%F')
  json.ends_on_format contest.ends_on&.strftime('%F')
end
