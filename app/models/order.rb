class Order < ActiveRecord::Base

  has_many :order_items, dependent: :delete_all
  # belongs_to :package
  # has_one :brief_request, dependent: :delete

  before_save :update_total_price



  enum payment_type: [:bitpay, :stripe]

  def update_total_price
    podcast_products_price, video_products_price, image_products_price, visual_setup_price = 0, 0, 0, 0

    # Podcast
    if order_items.podcast.present?
      order_items.podcast.each { |o| podcast_products_price += o.product.price * o.quantity * o.duration }
      if podcast_products_price > 0
        podcast_products_price += Product.product_type("podcast-setup").take.price
      end
    end

    # Video
    if order_items.video.present?
      order_items.video.each do |o|
        video_products_price += o.product.price * o.quantity * o.duration

        extra_formats = -1
        extra_formats += 1 if o.format_horizontal
        extra_formats += 1 if o.format_vertical
        extra_formats += 1 if o.format_square
        extra_formats += 1 if o.format_custom
        if extra_formats > 0 && o.duration > 0
          video_products_price += Product.product_type("extra-video-format").take.price * extra_formats * o.quantity
        end

        # Video Distribution
        order_items.video_distribution.each { |od| video_products_price += od.product.price * od.quantity * o.quantity } if order_items.video_distribution.present? && o.duration > 0
      end
    end

    # Visual
    if order_items.image.present?
      order_items.image.each do |o|
        image_products_price += o.product.price * o.quantity

        # Visual Distribution
        order_items.visual_distribution.each { |od| image_products_price += od.product.price * od.quantity * o.quantity } if order_items.visual_distribution.present?
      end
    end

    if order_items.video.present? || order_items.image.present?
      if video_products_price > 0 || image_products_price > 0
        visual_setup_price += Product.product_type("visual-setup").take.price
      end
    end

    price = podcast_products_price +
            video_products_price +
            image_products_price +
            visual_setup_price

    price = price + price * 0.20 if subscription_type == 1

    price = process_discount_code(price) if discount_code.present?

    self.total_price = price.ceil

    self.total_price = 0.5 if nullified?
  end

  def process_discount_code(price)
    correct_discount_codes = {
      "uncommon" => 0.1,
      "UNCOMMON" => 0.1,
      "NEUMEDIA" => 0.1,
      "Podcast" => 0.1,
      "YBFMembers" => 0.1,
      "COINJAR" => 0.35
    }

    if correct_discount_codes.include? discount_code
      price = price - price * correct_discount_codes[discount_code]
    end

    self.discount_code_applied = true

    price
  end

  def check_discount_code
    discount_code_applied
  end

  def pay
    self.paid = true
    self.paid_at = DateTime.now
    self.save
  end

  def nullified?
    discount_code == "just50cents"
  end

  def order_valid?
    customer_info_present? &&
    products_picked? &&
    final_details_present?
  end

  def customer_info_present?
    self.specifics_business.present? &&
    self.specifics_goal.present? &&
    self.specifics_regularity.present? &&
    self.specifics_style.present?
  end

  def products_picked?
    self.total_price > 0
  end

  def final_details_present?
    self.name.present? &&
    self.email.present? &&
    self.phone_number.present? &&
    self.country.present?
  end

end
