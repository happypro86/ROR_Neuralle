json.extract! product, :id, :position, :name, :price, :description, :prduct_type, :created_at, :updated_at
json.url product_url(product, format: :json)
