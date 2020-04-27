json.array! @permissions do |permission|
  json.id permission.id
  json.role permission.role
  json.fullname permission.user&.fullname
  json.email permission.user&.email
  if permission.role == 'university_manager'
    json.text_role permission.text_role + '-' + permission.context.title
  elsif permission.role == 'expert'
    json.text_role permission.text_role + '-' + permission.context.name
  else
    json.text_role permission.text_role
  end
end
