json.status 200
json.id @criterion.id
json.partial! 'shared/notifications', model: 'criterion'
