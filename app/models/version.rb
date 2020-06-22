# == Schema Information
#
# Table name: versions
#
#  id              :bigint           not null, primary key
#  item_type       :string           not null
#  item_id         :bigint           not null
#  event           :string           not null
#  whodunnit       :string
#  object          :text
#  additional_info :text
#  created_at      :datetime
#  object_changes  :text
#
class Version < PaperTrail::Version
  def user
    User.find_by(id: whodunnit)
  end

  def self.available_events
    Version.pluck(:event).uniq.compact
  end
end
