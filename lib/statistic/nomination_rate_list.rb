class Statistic::NominationRateList
  attr_accessor :ws, :wb, :style, :report, :common_styles

  def initialize(contest_id, nomination_id)
    @contest = Contest.find(contest_id)
    @criterions = @contest.criterions
    @nomination = Nomination.find(nomination_id)
    @participants = @nomination.participants
    @experts = @contest.experts.active
    @report = Axlsx::Package.new
  end

  def header
    header = [
      "№",
      "Организация",
      "ФИО участника",
      "Название доклада"
    ]
    second_header = ['', '', '', '']
    @experts.each do |expert|
      @criterions.each_with_index do |criterion, index|
        if index == 0
          header.push(expert.name)
        else
          header.push('')
        end
        second_header.push('К '+(index + 1).to_s)
      end
    end
    header.push('Итого баллов', 'Количество экспертов', 'Рейтинговый балл')
    second_header.push('', '', '')
    return [header, second_header]
  end


  def generate
    report.use_shared_strings = true
    @wb = report.workbook
    @ws = wb.add_worksheet(name: @nomination.code + '- итоговый рейтинг')
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
    merge_start = 4
    @experts.each do |expert|
      merge_end = merge_start + @criterions.count
      ws.merge_cells ws.rows.first.cells[(merge_start..(merge_end-1))]
      merge_start = merge_end
    end
    ws.add_row header[1], style: [@style] * header[1].count
  end

  def set_data
    common_styles.merge!(b: false)
    wb.styles { |s| @style = s.add_style common_styles }
    @participants.sort_by {|p| p.rate_mark }.reverse.each_with_index do |participant, index|
      data = [
        index + 1,
        participant.organization,
        participant.name,
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
      data.push(participant.marks_sum)
      data.push(participant.rated_experts.count)
      data.push(participant.rate_mark)
      ws.add_row data, types: [:string]  * data.count, style: [@style] * data.count
    end
  end

  def serialize_report
    report.serialize(Rails.root.join(%(nomination_rate_list.xlsx)))
  end
end
