json.array! @permissions do |permission|
  json.id permission.id
  json.role permission.role
  json.text_role permission.text_role
  json.fullname permission.user.fullname
end
