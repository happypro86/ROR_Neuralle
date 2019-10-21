class OrderItemsController < ApplicationController
  before_action :set_order
  before_action :set_order_items, only: [:update]
  before_action :set_products, only: [:update]
  # before_action :set_setup_products, only: [:update]


  def create
    @order_item = @order.order_items.new(order_item_params)
    @order_item.save
    @order.update(total_price: @order.update_total_price)
    respond_to :js
  end

  def update
    @order_item.update(order_item_params)
    @order.update(total_price: @order.update_total_price)
    respond_to :js
  end

  private

    def set_order
  		@order = current_order
  	end

    def set_order_items
      @order_item = OrderItem.find(params[:id])
      @order_items = @order.order_items.present.order("created_at DESC")

      @podcast_order_items = @order_items.podcast
      @video_order_items = @order_items.video
      @image_order_items = @order_items.image
      @video_distribution_order_items = @order_items.video_distribution
      @visual_distribution_order_items = @order_items.visual_distribution

      @podcast_host_order_item = @order_items.podcast_host.first
      @videographer_hire_order_item = @order_items.videographer_hire.first
    end

    def set_products
      @podcast_products = Product.product_type("podcast").order("position ASC")
      @video_products = Product.product_type("video").order("position ASC")
      @image_products = Product.product_type("image").order("position ASC")
      @video_distribution_products = Product.product_type("video-distribution").order("position ASC")
      @visual_distribution_products = Product.product_type("visual-distribution").order("position ASC")

      # @podcast_setup_product = Product.product_type("podcast-setup").take
      # @visual_setup_product = Product.product_type("visual-setup").take
      # @management_products = Product.product_type("management").order("position ASC")

      @podcast_host_product = Product.product_type("podcast-host").first
      @videographer_hire_product = Product.product_type("videographer-hire").first

      # @management_product_price = @management_products.take.price
      @video_distribution_product_price = @video_distribution_products.take.price
      @visual_distribution_product_price = @visual_distribution_products.take.price

      # @rss_distribution_product_price = @rss_distribution_product.price
  	end

    # def set_setup_products
    #   @podcast_setup_product = Product.product_type("podcast-setup").take
    #   @content_setup_product = Product.product_type("content-setup").take
    # end

    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id, :order_id, :duration, :format_horizontal, :format_vertical, :format_square, :format_custom, :host_budget, :footage_per_hour)
    end
end
