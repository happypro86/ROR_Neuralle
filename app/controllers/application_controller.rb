class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :find_footers, :find_all_service_options

  helper_method :current_order

private

  def find_footers
    @left_footers = Refinery::Footers::Footer.left.asc
    @right_footers = Refinery::Footers::Footer.right.desc
  end

  def find_all_service_options
    @service_options = Refinery::ServiceOptions::ServiceOption.all
  end

  def create_current_order
    cookies.delete :latest_tab
    current_order = Order.create
    session[:order_id] = current_order.id
    current_order
  end

  def current_order
    order = Order.find(session[:order_id])
    if order.paid?
      order = create_current_order
    end
    order
  rescue ActiveRecord::RecordNotFound
    create_current_order
  end

end
