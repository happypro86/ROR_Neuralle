class OrderItem < ActiveRecord::Base

  belongs_to :product
  belongs_to :order

  validates_uniqueness_of :product_id, scope: :order_id
	validates :product_id, presence: true
	validates :order_id, presence: true

  scope :present, ->{ where("quantity > ?", 0) }
  scope :podcast, ->{ joins(:product).where(products: { product_type: "podcast" }) }
  scope :video, ->{ joins(:product).where(products: { product_type: "video" }) }
  scope :image, ->{ joins(:product).where(products: { product_type: "image" }) }
  scope :video_distribution, ->{ joins(:product).where(products: { product_type: "video-distribution" }) }
  scope :visual_distribution, ->{ joins(:product).where(products: { product_type: "visual-distribution" }) }

  scope :podcast_host, ->{ joins(:product).where(products: { product_type: "podcast-host" }) }
  scope :videographer_hire, ->{ joins(:product).where(products: { product_type: "videographer-hire" }) }

end
