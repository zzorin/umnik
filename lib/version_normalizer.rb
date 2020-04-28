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

      if [true, false].include?(value)
        value ? 'Да' : 'Нет'
      elsif type == 'Vacancy'
        value_for_vacancy(key, value)
      elsif type == 'FileCopy' && value.present?
        value_label_for_file(key, value)
      elsif type == 'Document' && value.present?
        value_for_document(key, value)
      elsif type == 'Organization'
        value_for_organization(key, value)
      else
        value
      end
    end.compact.join(divider)
  end

  def value_for_organization(key, value)
    case key.to_sym
    when :state
      Organization.available_states_with_human_name[value.to_sym] rescue 'Не указана'
    else
      value
    end
  end

  def value_for_vacancy(key, value)
    case key.to_sym
    when :state
      Vacancy.available_states_with_human_name[value.to_sym] rescue 'Не указана'
    when :salary_currency, :category, :schedule, :education
      if value
        I18n.t("enumerize.vacancy.#{key.to_s}.#{value}").to_s
      else
        'Нет значения'
      end
    when :created_on
      I18n.l(value, format: :long) rescue 'Не указана'
    else
      value
    end
  end

  def value_for_document(key, value)
    case key.to_sym
    when :kind
      I18n.t("enumerize.document.kind.#{value}")
    when :approval_date
      I18n.l(value, format: :long)
    else
      value
    end
  end

  def value_label_for_file(key, value)
    case key.to_sym
    when :document_type
      I18n.t("enumerize.file_copy.document_type.#{value}")
    end
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
end
