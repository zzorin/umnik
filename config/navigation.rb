SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :main_page, 'Главная', root_path

    if current_user
      primary.item :administrator, t('permissions.administrator'), administrator_root_path if current_user.administrator?
      primary.item :university_manager, t('permissions.university_manager'), university_manager_root_path if current_user.university_manager?
      primary.item :expert, t('permissions.expert'), expert_root_path if current_user.expert?
    end
  end
end

SimpleNavigation.register_renderer first_renderer:       FirstRenderer
SimpleNavigation.register_renderer second_renderer:      SecondRenderer
SimpleNavigation.register_renderer mobile_menu_renderer: MobileMenuRenderer
