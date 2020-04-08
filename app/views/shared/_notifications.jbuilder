model = model.downcase.pluralize

json.notifications do
  json.title I18n.t("notifications.#{model}.#{action_name}.title")
  json.text I18n.t("notifications.#{model}.#{action_name}.text")
end
