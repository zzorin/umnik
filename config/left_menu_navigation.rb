SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :contest, 'Конкурс', contest_path(@contest)
    primary.item :criterions, 'Критерии отбора', contest_criterions_path(@contest)
    primary.item :nominations, 'Номинации', contest_nominations_path(@contest)
    primary.item :participants, 'Участники', contest_participants_path(@contest)
    primary.item :experts, 'Эксперты', contest_experts_path(@contest)
    primary.item :marks, 'Оценки', contest_expert_marks_path(@contest, @contest.experts.first)
  end
end

SimpleNavigation.register_renderer left_menu_renderer: LeftMenuRenderer
