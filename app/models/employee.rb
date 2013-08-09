class Employee < ActiveRecord::Base
  belongs_to :company
  has_many :taxirequests
  has_many :stationeryrequests
  validates_associated :taxirequests
  validates_associated :stationeryrequests
  
  attr_accessible :employee, :password, :position, :picture, :company_id
  validates :employee, :position, :company_id, :presence => true
  validates_presence_of :password, :on => :create
  validates :employee, :uniqueness => true
  
  before_save :encrypt_password
  
  has_attached_file :picture, :styles => { :small => "200x200>" }
  
  def self.authenticate(employee_name, password)
    employee = find_by_employee(employee_name)
    # если сотрудник с таким именем найден, то сравнить пароли
    if employee && employee.password == BCrypt::Engine.hash_secret(password, employee.salt)
      employee
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, salt)
    end  
  end
  
end
