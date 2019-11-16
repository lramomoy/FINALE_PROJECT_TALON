class RemoveBookingIdFromFeedbacks < ActiveRecord::Migration[5.2]
  def change
    remove_column :feedbacks, :booking_id, :integer
  end
end
