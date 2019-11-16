class Service < ApplicationRecord

  validates_presence_of :name, :price, :description

end
