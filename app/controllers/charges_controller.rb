require 'bitpay_sdk'

class ChargesController < ApplicationController
  before_action :set_order
  before_action :set_bitpay_service, only: [:bitpay]

  def new
  end

  def create
    amount = (@order.total_price * 100).to_i
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    if @order.subscription_type == 1
      create_one_time_payment(amount, customer)
    else
      create_subscription(amount, customer)
    end

    @order.pay

    cookies.delete :latest_tab

    # TODO: Implement email exceptions catcher and notifier
    OrderMailer.order_purchase(@order).deliver_later rescue redirect_to completed_order_path(@order)
    OrderMailer.send_receipt(@order).deliver_later rescue redirect_to completed_order_path(@order)

    redirect_to completed_order_path(@order)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def create_one_time_payment(amount, customer)
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: amount,
      description: 'Neuralle Media Services One Time Payment',
      currency: 'aud'
    )
  end

  def create_subscription(amount, customer)
    product = Stripe::Product.create({
      name: "Neuralle Media Services",
      type: "service"
    })

    plan = Stripe::Plan.create({
      currency: 'aud',
      interval: 'month',
      product: product.id,
      nickname: 'Monthly Subscription',
      amount: 1
    })

    subscription = Stripe::Subscription.create({
      customer: customer.id,
      items: [{
        plan: plan.id,
        quantity: amount
      }]
    })
  end

  def bitpay
    if @order.subscription_type == 1
      token = SecureRandom.urlsafe_base64
      invoice = @service.create_invoice(@order, bitpay_callback_charges_url(token: token))
      session[:bitpay_token] = token

      redirect_to invoice['url']
    else
      redirect_to new_charge_path
    end
  rescue StandardError => ex
    flash[:error] = ex.message
    redirect_to new_charge_path
  end

  def bitpay_callback
    if params[:token] == session[:bitpay_token]
      @order.pay

      OrderMailer.order_purchase(@order).deliver_later rescue redirect_to completed_order_path(@order)

      redirect_to completed_order_path(@order)
    end
  end

  private

  def set_order
    @order = current_order
    # @brief_request = @order.brief_request
  end

  def set_bitpay_service
    @service = BitpayService.new
  end

end
