class Statistic::Protocol
  attr_accessor :ws, :wb, :style, :report, :common_styles

  def initialize(contest_id=34, nomination_id)
    @contest = Contest.find(contest_id)
    if nomination_id.present?
      @nomination = Nomination.find(nomination_id)
    end
    @participants = @contest.participants
    @report = Axlsx::Package.new
  end

  def header
    [
      "№",
      "ФИО участника",
      "Название доклада",
      "Направление",
      "Организация",
      "Контактные данные"
    ]
  end


  def generate
    report.use_shared_strings = true
    @wb = report.workbook
    @ws = wb.add_worksheet(name: 'Протокол')
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
    ws.add_row header, style: [@style] * header.count
  end

  def set_data
    common_styles.merge!(b: false)
    wb.styles { |s| @style = s.add_style common_styles }
    @participants.each_with_index do |participant, index|
      data = [
        index + 1,
        participant.shortname,
        participant.project_title,
        participant.nomination.title,
        participant.organization,
        participant.contact_info
      ]
      ws.add_row data, types: [:string]  * data.count, style: [@style] * data.count
    end
  end

  def serialize_report
    report.serialize(Rails.root.join(%(protocol.xlsx)))
  end
end
