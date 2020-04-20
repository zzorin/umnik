module Administrator::AccessRules
  def access_rules
    {
      permissions: permissions_rules,
      contests: contests_rules
    }
  end

  private

  def permissions_rules
    { manage: can?(:manage, Permission) }
  end

  def contests_rules
    {
      manage: can?(:manage, Contest),
      create: can?(:create, Contest),
      new: can?(:new, Contest)
    }
  end
end
