class OrdersController < ApplicationController

  before_action :set_order
  before_action :set_products
  before_action :set_order_items

  def edit
  end

  def update
    @order.update(order_params)
    respond_to :js

    if customer_details_filled? && (@order.lead_mail_sent == false) && !Rails.env.development
      @order.lead_mail_sent = true
      @order.save!
      OrderMailer.customer_details_lead(@order).deliver_later rescue nil
    end
  end

  def reset_order
    @order.subscription_type = 1
    @order.terms_agreed = false
    @order.total_price = 0
    @order.discount_code = nil
    @order.discount_code_applied = false
    @order.order_items.each do |oi|
      oi.quantity = 0
      oi.duration = 0
      oi.format_horizontal = true
      oi.format_vertical = false
      oi.format_square = false
      oi.format_custom = false
      oi.footage_per_hour = 0
      oi.save
    end
    @order.paid = false
    @order.specifics_business = nil
    @order.specifics_goal = nil
    @order.specifics_regularity = nil
    @order.specifics_style = nil
    @order.name = nil
    @order.email = nil
    @order.phone_number = nil
    @order.country = nil
    @order.lead_mail_sent = false
    @order.save

    cookies.delete :latest_tab

    respond_to :js
  end

  def completed_order
    redirect_to pricing_page_path unless @order.paid
  end

  def lead_capture
    @name = params[:name]
    @email = params[:email]
    @phone = params[:phone]

    if params[:address].empty?
      ContactFormMailer.save_quote(@name, @email, @phone).deliver_later
    end
  end

  private

    def set_order
      @order = params[:action] == "completed_order" ? Order.find(params[:order_id]) : current_order

      Product.all.each do |p|
        order_item = @order.order_items.where(product_id: p.id).first
          OrderItem.create(order_id: @order.id, product_id: p.id) unless order_item.present?
      end

    rescue ActiveRecord::RecordNotFound
      redirect_to pricing_page_path
  	end

    def set_products
      @podcast_products = Product.product_type("podcast").order("position ASC")
      @video_products = Product.product_type("video").order("position ASC")
      @image_products = Product.product_type("image").order("position ASC")
      @video_distribution_products = Product.product_type("video-distribution").order("position ASC")
      @visual_distribution_products = Product.product_type("visual-distribution").order("position ASC")

      @podcast_host_product = Product.product_type("podcast-host").first
      @videographer_hire_product = Product.product_type("videographer-hire").first

      @video_distribution_product_price = @video_distribution_products.take.price
      @visual_distribution_product_price = @visual_distribution_products.take.price
  	end

    def set_order_items
      @order_items = @order.order_items.present.order("created_at DESC")

      @podcast_order_items = @order_items.podcast
      @video_order_items = @order_items.video
      @image_order_items = @order_items.image

      @video_distribution_order_items = @order_items.video_distribution
      @visual_distribution_order_items = @order_items.visual_distribution
    end

    def customer_details_filled?
      @order.specifics_business.present? &&
      @order.specifics_goal.present? &&
      @order.specifics_regularity.present? &&
      @order.specifics_style.present? &&
      @order.name.present? &&
      @order.email.present? &&
      @order.phone_number.present? &&
      @order.country.present?
    end

    def order_params
      params.require(:order).permit(:terms_agreed, :total_price, :subscription_type, :package_id, :discount_code, :specifics_business, :specifics_goal, :specifics_regularity, :specifics_style, :email, :name, :phone_number, :country, :company, :lead_mail_sent)
    end

end
