json.status 200
json.id @nomination.id
json.partial! 'shared/notifications', model: 'nomination'
