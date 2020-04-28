class Version < PaperTrail::Version
  def user
    User.find_by(id: whodunnit)
  end
end
