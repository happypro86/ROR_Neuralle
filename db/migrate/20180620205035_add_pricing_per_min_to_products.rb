class AddPricingPerMinToProducts < ActiveRecord::Migration
  def change
    add_column :products, :pricing_per_min, :boolean, default: false
  end
end
