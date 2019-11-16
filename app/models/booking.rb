class Booking < ApplicationRecord

  belongs_to :customer
  belongs_to :service

  validates_presence_of :booking_date, :booking_time
  validates :booking_date, uniqueness: {scope: :booking_time, message: 'slot already taken'} 

  def self.slots
    ['3:30 pm – 5:30 pm', '5:30 pm – 7:30 pm', '7:30 pm – 9:30 pm']
  end

  def date_and_time
    "#{booking_date} At #{booking_time}"
  end

  def self.available_slots_on(date)
    bookings_for_today = Booking.where(:booking_date => date)
    Booking.slots - bookings_for_today.map(&:booking_time)
  end
end
