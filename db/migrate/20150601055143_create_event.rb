class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string    :address
      t.string    :venue_name
      t.string    :city
      t.string    :country
      t.datetime  :time
      t.string    :name
      t.text      :description
      t.string    :event_url
      t.string    :group_url
      t.integer   :uid

      t.index     :time
      t.index     :uid
    end
  end
end
