require "administrate/field/base"

class BookingStatusField < Administrate::Field::Base
  def to_s
    data&.titleize
  end
end
