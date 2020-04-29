json.status 200
json.id @participant.id
json.partial! 'shared/notifications', model: 'participant'
