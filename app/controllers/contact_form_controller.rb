class ContactFormController < ApplicationController
  def submit
    mail_params = form_params.to_h
    mail_params['to'] = Refinery::Setting.find_or_set(:contact_form_to, 'jordan@neuralle.com')
    Thread.new do
      ContactFormMailer.contact_form_email(mail_params).deliver_now
      ActiveRecord::Base.connection.close
    end
    flash[:success] = "Thanks! We'll be in touch shortly."
    redirect_to(params[:returnTo])
  end

  private

  def form_params
    params.permit(
      :name,
      :company,
      :email,
      :phone,
      :requested_date,
      :time,
      :message,
      :returnTo,
      :service_options => []
    )
  end
end
