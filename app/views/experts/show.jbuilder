json.call(@expert, :id, :surname, :name, :patronymic, :contest_id, :active)
json.permission do
  json.id @expert.permission&.id
  json.user_id @expert.permission&.user_id
  json.context_type @expert.permission&.context_type
  json.role @expert.permission&.role
  json.fullname @expert.permission&.user&.fullname
end
