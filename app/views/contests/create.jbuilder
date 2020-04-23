json.status 200
json.id @contest.id
json.partial! 'shared/notifications', model: 'contest'
