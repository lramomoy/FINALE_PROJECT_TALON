class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :customer_id
      t.integer :service_id
      t.date :booking_date
      t.string :booking_time
      t.text :special_request

      t.timestamps
    end
  end
end
