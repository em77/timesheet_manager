module TimesheetsHelper
  def status_id_maker(id)
    "status-" + id.to_s
  end

  def status_css_maker(timesheet)
    if timesheet.approved?
      "glyphicon glyphicon-ok status_approved"
    else
      "status_unapproved"
    end
  end

  def timesheets_total_hours(timesheets)
    timesheets.reduce(0) { |sum, t| sum += hours_calc(t.clock_in, t.clock_out) }
      .round(2)
  end
end
