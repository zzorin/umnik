json.status 200
json.history do
  json.array! @mark.versions do |version|
    normalizer = VersionNormalizer.new(version)
    json.whodunnit do
      json.fullname normalizer.user.fullname
    end if normalizer.user.present?
    json.expert @mark&.expert&.name
    json.event normalizer.set_event_title
    json.changes normalizer.set_version_changes
    json.created_at I18n.l(version.created_at, format: :long)
  end
end

