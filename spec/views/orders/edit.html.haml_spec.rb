require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :terms_agreed => false,
      :total_price => 1.5,
      :subscription_type => 1
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input#order_terms_agreed[name=?]", "order[terms_agreed]"

      assert_select "input#order_total_price[name=?]", "order[total_price]"

      assert_select "input#order_subscription_type[name=?]", "order[subscription_type]"
    end
  end
end
