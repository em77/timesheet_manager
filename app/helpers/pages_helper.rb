module PagesHelper
  def latest_pay_period(job)
    job.pay_periods.where( pay_date: job.pay_periods.maximum(:pay_date) ).first
  end

  def upcoming_pay_date_header(company_title, job_title, there_is_pay_date,
    pay_date = nil)
    if there_is_pay_date
      pay_date_formatted = pay_date.strftime("%A, %b %d, %Y")
    else
      pay_date_formatted = "No upcoming pay date"
    end
    %Q(
      <h3>
        #{company_title}
        <small>
          #{job_title}
        </small>
        <span class="pay-date-text">
          #{pay_date_formatted}
        </span>
      </h3>
    ).html_safe
  end
end
