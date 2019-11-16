require "administrate/field/base"

class TelephoneField < Administrate::Field::Base
  def to_s
    data
  end
end
