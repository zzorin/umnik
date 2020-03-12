SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :criterions, 'Конкурс', contest_path(@contest)
    primary.item :criterions, 'Критерии отбора', contest_criterions_path(@contest)
    primary.item :nominations, 'Номинации', contest_nominations_path(@contest)
  end
end

SimpleNavigation.register_renderer left_menu_renderer: LeftMenuRenderer
