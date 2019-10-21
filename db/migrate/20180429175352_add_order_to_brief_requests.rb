class AddOrderToBriefRequests < ActiveRecord::Migration
  def change
    add_reference :brief_requests, :order, index: true, foreign_key: true
  end
end
