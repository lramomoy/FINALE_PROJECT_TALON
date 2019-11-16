class Customer < ApplicationRecord

  has_many :bookings
  validates_presence_of :first_name, :last_name, :email, :phone_number

  def full_name
    "#{first_name} #{last_name}"
  end
end
