class Product < ActiveRecord::Base

  has_many :order_items, dependent: :delete_all

  scope :product_type, ->(product_type){where(product_type: product_type)}

end
