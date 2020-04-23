json.status 200
json.id @permission.id
json.partial! 'shared/notifications', model: 'permission'
