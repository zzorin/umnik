class Version < PaperTrail::Version
  def user
    User.find_by(id: whodunnit)
  end

  def self.available_events
    Version.pluck(:event).uniq.compact
  end
end
