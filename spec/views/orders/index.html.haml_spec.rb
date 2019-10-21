require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        :terms_agreed => false,
        :total_price => 2.5,
        :subscription_type => 3
      ),
      Order.create!(
        :terms_agreed => false,
        :total_price => 2.5,
        :subscription_type => 3
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
