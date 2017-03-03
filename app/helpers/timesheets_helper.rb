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
end
