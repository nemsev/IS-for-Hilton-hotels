class Company < ActiveRecord::Base
  attr_accessible :name
  has_many :employees
  validates_associated :employees
end
