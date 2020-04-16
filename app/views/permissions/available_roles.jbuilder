# json.array! Permission.available_roles do |role|
#   json.role role
#   json.title I18n.t("permissions.#{role}")
#   if role == 'university_manager'
#     json.context do
#       json.array! Contest.all do |contest|
#         json.id contest.id
#         json.title contest.title
#       end
#     end
#   end
#   if role == 'expert'
#     json.context do
#       json.array! Expert.all do |expert|
#         json.id expert.id
#         json.title expert.fullname
#         json.contest_id expert.contest_id
#         json.contest_name expert.contest.title
#       end
#     end
#   end
# end

  Permission.available_roles.each do |role|
    json.set! role do
      json.title I18n.t("permissions.#{role}")
      if role == 'university_manager'
        json.context_type 'Contest'
        json.contexts do
          json.array! Contest.all do |contest|
            json.context_id contest.id
            json.title contest.title
          end
        end
      end
      if role == 'expert'
        json.context_type 'Expert'
        json.contexts do
          json.array! Expert.all do |expert|
            json.context_id expert.id
            json.title expert.fullname + '-'+ expert.contest.title
          end
        end
      end
    end
  end