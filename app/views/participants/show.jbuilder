json.call(@participant, :id, :name, :organization,
  :project_title, :contact_info, :nomination_id)
json.permission do
  json.id @participant.permission&.id
  json.user_id @participant.permission&.user_id
  json.context_type @participant.permission&.context_type
  json.role @participant.permission&.role
  json.fullname @participant.permission&.user&.fullname
end
