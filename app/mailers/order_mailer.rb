class OrderMailer < ApplicationMailer

  add_template_helper(ApplicationHelper)

  def order_purchase(order)
    attachments.inline['narrow_mail_header.png'] = File.read("#{Rails.root}/app/assets/images/mailers/narrow_mail_header.png")

    @order = order
    @total_price = @order.total_price
    @email = @order.email
    @customer_name = @order.name
    @purchase_time = Time.current

    # @to = "jordan@neuralle.com, lauren@neuralle.com"
    @to = "ant.khay@gmail.com, jordan@neuralle.com, lauren@neuralle.com"
    # @to = "ant.khay@gmail.com"

    mail(to: @to, subject: "New purchase at neuralle.com: #{@customer_name}, #{@purchase_time.strftime("%m/%d/%Y at %I:%M %p")}, $#{@total_price}")
  end

  def send_receipt(order)
    attachments.inline['customer_mail_header.png'] = File.read("#{Rails.root}/app/assets/images/mailers/customer_mail_header.png")

    @order = order
    @email = @order.email
    @purchase_time = @order.paid_at.present? ? @order.paid_at.strftime("%B %d, %Y") : "11 November, 2011"

    mail(to: @email, subject: "Your purchase at neuralle.com")
  end

  def customer_details_lead(order)
    @order = order
    @customer_name = @order.name
    @time = Time.current

    # @to = "jordan@neuralle.com, lauren@neuralle.com"
    @to = "ant.khay@gmail.com, jordan@neuralle.com, lauren@neuralle.com"
    # @to = "ant.khay@gmail.com"

    mail(to: @to, subject: "New lead at neuralle.com: #{@customer_name}, #{@time.strftime("%m/%d/%Y at %I:%M %p")}")
  end

end
