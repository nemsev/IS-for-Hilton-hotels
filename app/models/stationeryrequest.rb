class Stationeryrequest < ActiveRecord::Base
  attr_accessible :status
  belongs_to :employee
  has_many :hotelsuppliesrequests
  validates_associated :hotelsuppliesrequests
  has_many :hotelsupplies, :through => :hotelsuppliesrequests
end
