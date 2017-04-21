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
    sum = 0
    timesheets.each { |t| sum += hours_calc(t.clock_in, t.clock_out) }
    sum.round(2)
  end
end
