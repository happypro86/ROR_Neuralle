class ContactFormMailerPreview < ActionMailer::Preview
  def save_quote
    ContactFormMailer.save_quote("Tony", "ant.khay@gmail.com", "+79232431311")
  end
end
