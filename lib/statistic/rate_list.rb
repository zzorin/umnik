class Statistic::RateList
  attr_accessor :ws, :wb, :style, :report, :common_styles

  def initialize(contest_id=34, nomination_id)
    @contest = Contest.find(contest_id)
    if nomination_id.present?
      @nomination = Nomination.find(nomination_id)
    end
    @criterions = @contest.criterions
    @participants = @contest.participants
    @experts = @contest.experts
    @report = Axlsx::Package.new
  end

  def header
    header = [
      "№",
      "Организация",
      "ФИО участника",
      "Название доклада",
      "Направление"
    ]
    second_header = ['', '', '', '', '']
    @experts.each do |expert|
      @criterions.each_with_index do |criterion, index|
        if index == 0
          header.push(expert.shortname)
        else
          header.push('')
        end
        second_header.push(criterion.title)
      end
    end
    header.push('Итого баллов', 'Количество экспертов', 'Рейтинговый балл')
    second_header.push('', '', '')
    return [header, second_header]
  end


  def generate
    report.use_shared_strings = true
    @wb = report.workbook
    @ws = wb.add_worksheet(name: 'Итоговый рейтинг')
    set_header
    set_data
    serialize_report
    @report
  end

  def set_header
    @common_styles = {
      alignment: {
        horizontal: :left,
        wrap_text: true,
        vertical: :top
      },
      border: {
        style: :thin,
        color: '00'
      },
      b: true,
    }

    wb.styles { |s| @style = s.add_style common_styles }
    ws.add_row header[0], style: [@style] * header[0].count
    ws.add_row header[1], style: [@style] * header[1].count
  end

  def set_data
    common_styles.merge!(b: false)
    wb.styles { |s| @style = s.add_style common_styles }
    @participants.each_with_index do |participant, index|
      data = [
        index + 1,
        participant.organization,
        participant.shortname,
        participant.project_title,
        participant.nomination.title,
      ]
      @experts.each do |expert|
        @criterions.each do |criterion|
          mark = Mark.find_by(participant_id: participant.id,
                              expert_id: expert.id,
                              criterion_id: criterion.id)
          mark.present? ? data.push(mark.grade) : data.push(0)
        end
      end
      data.push(participant.marks.sum(&:grade))
      data.push(@experts.count)
      data.push((participant.marks.sum(&:grade) / @experts.count.to_f).round(2))
      ws.add_row data, types: [:string]  * data.count, style: [@style] * data.count
    end
  end

  def serialize_report
    report.serialize(Rails.root.join(%(rate_list.xlsx)))
  end
end
