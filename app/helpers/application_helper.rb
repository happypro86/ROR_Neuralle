module ApplicationHelper
  def admin_logged_in?
    display_site_bar?
  end

  def footer_display_name(footer)
    name_elements = []
    name_elements << footer.text if footer.text.present?
    name_elements << icon(footer.icon) if footer.icon.present?
    name_elements.join(' ')
  end

  def display_footer(footer)
    if footer.link.present?
      link_to raw(footer_display_name(footer)), footer.link
    else
      footer_display_name(footer)
    end
  end

  def bootstrap_class_for(flash_type)
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || "alert-#{flash_type}"
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissable fade in", role: 'alert') do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

  def first_refinery_page_default_part
    Refinery::Pages.default_parts.first.try(:[], :slug)
  end

  def get_blog_image_url(post)
    post_body = Nokogiri::HTML(post.body)
    post_body.xpath('//img').first.try(:attr, 'src')
  end

  # Order helpers

  def order_items
    @order.order_items.present.order("created_at DESC")
  end

  def podcast_order_items
    @order.order_items.present.podcast.order("position ASC")
  end

  def video_order_items
    @order.order_items.present.video.order("position ASC")
  end

  def image_order_items
    @order.order_items.present.image.order("position ASC")
  end

  def video_order_item
    @order.order_items.present.video.order("position ASC").take
  end

  def image_order_item
    @order.order_items.present.image.order("position ASC").take
  end

  def videographer_hire_order_item
    @order.order_items.present.videographer_hire.first
  end

  def podcast_host_order_item
    @order.order_items.podcast_host.first
  end

  def image_order_items_quantity
    quantity = 0
    image_order_items.each { |oi| quantity += oi.quantity }
    quantity
  end

  def videographer_hire_order_item
    @order.order_items.videographer_hire.first
  end

  def video_distribution_order_items
    @order.order_items.present.video_distribution.order("position ASC")
  end

  def visual_distribution_order_items
    @order.order_items.present.visual_distribution.order("position ASC")
  end

  def podcast_setup_product
    Product.product_type("podcast-setup").take
  end

  def visual_setup_product
    Product.product_type("visual-setup").take
  end

  def review_product(order_item)
    order_item.product.try(:name)
  end

  def review_product_with_duration(order_item)
    "#{order_item.product.try(:name)} (#{order_item.duration}min)"
  end

  def review_product_quantity(order_item)
    order_item.quantity
  end

  def set_discount(price, ceil = true)
    price = price + price * 0.20 if @order.subscription_type == 1
    price = price.ceil if ceil
    price
  end

  def formatted_price(price, with_discount = true)
    price = with_discount ? set_discount(price) : price
    number_with_precision(
      price,
      strip_insignificant_zeros: true,
      precision: 2
    )
  end

  def formatted_price_with_symbol(price)
    "A$#{formatted_price(price)}"
  end

  def review_product_price(order_item)
    price = order_item.product.try(:price) * order_item.quantity
    price = price * order_item.duration if order_item.duration > 0

    extra_formats = -1
    extra_formats += 1 if order_item.format_horizontal
    extra_formats += 1 if order_item.format_vertical
    extra_formats += 1 if order_item.format_square
    extra_formats += 1 if order_item.format_custom
    if extra_formats > 0 && order_item.duration > 0
      price += Product.product_type("extra-video-format").take.price * extra_formats * order_item.quantity
    end

    formatted_price_with_symbol(price)
  end

  def review_video_distribution_product_price
    price = video_distribution_order_items.take.product.price
    quantity = video_distribution_order_items.count

    formatted_price_with_symbol(price * quantity * video_order_item.quantity)
  end

  def review_visual_distribution_product_price
    price = visual_distribution_order_items.take.product.price
    quantity = visual_distribution_order_items.count

    formatted_price_with_symbol(price * quantity * image_order_items_quantity)
  end

  def total_price
    "A$#{formatted_price(@order.total_price, false)}"
  end

  def page_controller_class
    class_name = "#{params[:controller].gsub("/", " ").gsub("_", " ")}_page #{params[:action]}_action"
    class_name += ' podcast show_action' if request.path == '/podcast'
    class_name
  end

  def podtrac_prefix(file_url)
    ENV['PODTRAC_FREFIX'] + file_url
  end

  def podcast_title(title)
    title.gsub("#", "")
  end

  def title_tag(page_title)
    content_for :title, page_title
  end

  def description_tag(page_description)
    content_for :description_tag, page_description
  end

  def order_specifics_business
    case @order.specifics_business
    when 1
      "B2B"
    when 2
      "B2C"
    end
  end

  def order_specifics_goal
    case @order.specifics_goal
    when 1
      "Build/grow an audience"
    when 2
      "Run a specific campaign"
    end
  end

  def order_specifics_regularity
    case @order.specifics_regularity
    when 1
      "Monthly"
    when 2
      "Once Off Campaign or Test Run"
    end
  end

  def order_specifics_style
    case @order.specifics_style
    when 1
      "Yes"
    when 2
      "No"
    when 3
      "I don't know"
    end
  end

  def show_video_distribution?
    @video_distribution_products.any? do |p|
      order_item(p.id).quantity > 0
    end
  end

  def show_visual_distribution?
    @visual_distribution_products.any? do |p|
      order_item(p.id).quantity > 0
    end
  end

  def podcast_host_present?
    podcast_host_order_item.footage_per_hour > 0
  end

  def videographer_hire_present?
    videographer_hire_order_item.duration > 0
  end

  def additional_services?
    podcast_host_present? || videographer_hire_present?
  end

  def country_name(code)
    country = ISO3166::Country[code]
    country.translations[I18n.locale.to_s] || country.name
  end

end
