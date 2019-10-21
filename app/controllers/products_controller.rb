class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  private

    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:position, :name, :price, :description, :prduct_type)
    end
end
