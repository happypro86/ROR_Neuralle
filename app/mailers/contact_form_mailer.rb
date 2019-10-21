class ContactFormMailer < ApplicationMailer

  add_template_helper(ApplicationHelper)

  def contact_form_email(params)
    raw_options = params['service_options'] || []
    service_options = Refinery::ServiceOptions::ServiceOption.find(raw_options.map{|option| option.to_i })
    @service_option_description = service_options.map do |option|
      option.title
    end.join(', ')
    @service_option_description = 'None selected' if service_options.empty?
    @params = params.except('to')
    mail(to: params['to'], subject: 'Someone wants to talk to you')
  end

  def save_quote(name, email, phone)
    @email = email
    @phone = phone
    @customer_name = name
    @time = Time.current

    # @to = "jordan@neuralle.com, lauren@neuralle.com"
    @to = "ant.khay@gmail.com, jordan@neuralle.com, lauren@neuralle.com"
    # @to = "ant.khay@gmail.com"

    mail(to: @to, subject: "New free consult request at neuralle.com: #{@customer_name}, #{@time.strftime("%m/%d/%Y at %I:%M %p")}")
  end
end
