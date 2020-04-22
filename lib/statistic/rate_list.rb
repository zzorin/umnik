class Statistic::RateList
  attr_accessor :ws, :wb, :style, :report, :common_styles

  def initialize(contest_id=34, nomination_id)
    @contest = Contest.find(contest_id)
    if nomination_id.present?
      @nomination = Nomination.find(nomination_id)
    end
    @report = Axlsx::Package.new
  end

  def header
    [
      "№",
      "Организация",
      "ФИО участника",
      "Название доклада",
      "Направление"
    ]
  end


  def generate
    report.use_shared_strings = true
    @wb = report.workbook
    @ws = wb.add_worksheet(name: 'Итоговый рейтинг')
    set_header
    # set_data
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
    ws.add_row header, style: [@style] * header.count
  end

  # def set_data
  #   common_styles.merge!(b: false)
  #   wb.styles { |s| @style = s.add_style common_styles }
  #   @lessons.each do |lesson|
  #     lesson.realizes.each do |realize|
  #       data = [
  #         realize.lecturer.subdepartments.try(:map) {|s| s['title']}.uniq.join(', '),
  #         realize.lecturer.full_name,
  #         realize.lecturer.academic_fields,
  #         lesson.discipline.title,
  #         lesson.group.number,
  #         I18n.t("lesson.time.#{lesson.order_number}"),
  #         realize.lecturer_presence ? 'да' : 'нет',
  #         realize.lecturer.user_id
  #       ]
  #       ws.add_row data, types: [:string]  * data.count, style: [@style] * data.count
  #       ws.column_widths *[50, 50, 50, 80, 15, 30, 20, 40]
  #     end
  #   end
  # end

  def serialize_report
    report.serialize(Rails.root.join(%(rate_list.xlsx)))
  end
end
