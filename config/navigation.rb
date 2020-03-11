SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :main_page, 'Главная', root_path

    if current_user
      primary.item :permissions_item, 'Управление правами', permissions_path #if can?(:manage, :spa)
    end
  end
end

#SimpleNavigation.register_renderer first_renderer:       FirstRenderer
#SimpleNavigation.register_renderer second_renderer:      SecondRenderer
#SimpleNavigation.register_renderer mobile_menu_renderer: MobileMenuRenderer
