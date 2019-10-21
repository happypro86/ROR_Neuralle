class BriefRequestsController < ApplicationController
  before_action :set_order

  def update
    @order.brief_request.update(brief_request_params)
  end

  private

  def set_order
    @order = current_order
    @brief_request = @order.brief_request
  end

  def brief_request_params
    params.require(:brief_request).permit(
      :name, :company, :email, :phone_number, :country,
      :industry, :brief_description, :brief_file, :design_style, :further_notes
    )
  end
end
