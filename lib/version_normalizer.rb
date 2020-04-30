class VersionNormalizer
  attr_accessor :version, :type, :user, :object_changes, :deleted_object

  def initialize(version)
    @version = version
    @type = version.item_type
    @deleted_object = init_hashie_mashie_object(version.object)
    @object_changes = init_hashie_mashie_object(version.object_changes)
    @user = User.find_by(id: version.whodunnit)
  end

  def init_hashie_mashie_object(object)
    return unless object.present?
    Hashie::Mash.new(YAML.load(object))
  end

  def set_version_changes
    return unless object_changes.present?

    result_object = {}

    type_fields_exceptions
    set_additional_info(result_object)
    object_changes.each do |key, value|
      result_object[I18n.t("paper_trail.#{type.to_s.underscore}.#{key}")] = format_changed_fields(key, value, ' -> ')
    end

    result_object
  end

  def set_additional_info(result_object)
    return unless version.additional_info.present?
    label = I18n.t("paper_trail.#{version.item_type.underscore}.additional_info")
    result_object[label] = version.additional_info
  end

  def type_fields_exceptions
    Version.all.map(&:item_type).uniq.each do |type|
      object_changes.except! *type.constantize.send(:paper_trail_expected_fields)
    end
  end

  def format_changed_fields(key, array, divider)
    array.map do |value|
      value = value.downcase if value.is_a?(String)
      value = 'не указано' if value.nil? && event_update?

      if [true, false].include?(value)
        value ? 'Да' : 'Нет'
      else
        value
      end
    end.compact.join(divider)
  end

  def set_event_title
    if user.present?
      gender = Petrovich(
        lastname: user.surname,
        firstname: user.name,
        middlename: user.patronymic
      ).gender
    else
      'У пользователя нет имени'
    end

    I18n.t("paper_trail.#{version.item_type.underscore.downcase}.#{gender}.#{version.event}")
  end

  Version.available_events.each do |event_name|
    define_method "event_#{event_name}?" do
      version.event == event_name
    end
  end
end
