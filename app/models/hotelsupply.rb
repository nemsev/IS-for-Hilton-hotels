class Hotelsupply < ActiveRecord::Base
  attr_accessible :cost, :name, :num
  has_many :hotelsuppliesrequests
  validates_associated :hotelsuppliesrequests
  has_many :stationeryrequests, :through => :hotelsuppliesrequests
end
