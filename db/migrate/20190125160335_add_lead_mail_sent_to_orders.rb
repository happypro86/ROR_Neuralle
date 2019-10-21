class AddLeadMailSentToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :lead_mail_sent, :boolean, default: false
  end
end
