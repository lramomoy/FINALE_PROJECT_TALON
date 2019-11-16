require "administrate/field/base"

class MoneyField < Administrate::Field::Base
  def to_s
    data
  end
end
