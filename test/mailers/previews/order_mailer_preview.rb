class OrderMailerPreview < ActionMailer::Preview
  def send_receipt
    OrderMailer.send_receipt(Order.all[-1])
  end

  def order_purchase
    OrderMailer.order_purchase(Order.all[-1])
  end

  def customer_details_lead
    OrderMailer.customer_details_lead(Order.all[-1])
  end
end
