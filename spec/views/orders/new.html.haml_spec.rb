require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      :terms_agreed => false,
      :total_price => 1.5,
      :subscription_type => 1
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "input#order_terms_agreed[name=?]", "order[terms_agreed]"

      assert_select "input#order_total_price[name=?]", "order[total_price]"

      assert_select "input#order_subscription_type[name=?]", "order[subscription_type]"
    end
  end
end
