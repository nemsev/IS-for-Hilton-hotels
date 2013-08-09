class Hotelsuppliesrequest < ActiveRecord::Base
  attr_accessor :selected
  attr_accessible :num
  attr_accessible :selected
  belongs_to :stationeryrequest
  belongs_to :hotelsupply
end
