class ChangeBriefRequestsFields < ActiveRecord::Migration
  def change
    rename_column :brief_requests, :region, :country

    remove_column :brief_requests, :brief_structure

    add_column :brief_requests, :industry, :string
    add_column :brief_requests, :design_style, :text
    add_column :brief_requests, :further_notes, :text
  end
end
