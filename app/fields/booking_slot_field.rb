require "administrate/field/base"

class BookingSlotField < Administrate::Field::Base
  def to_s
    data
  end
end
