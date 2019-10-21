module ChargesHelper
  def payment_description
    @order.subscription_type == 1 ? "One Time Payment" : "Monthly Subscription"
  end
end
