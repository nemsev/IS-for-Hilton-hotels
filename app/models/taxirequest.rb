class Taxirequest < ActiveRecord::Base
  require 'uri'
  require 'net/http'
  attr_accessible :destination, :room, :arrival_date, :arrival_time, :payment_method, :cost, :order_number, :guest_name, :status
  belongs_to :employee
  
  validates :destination, :arrival_date, :arrival_time, :payment_method, :presence => true
  #validates_presence_of :employee_id, :on => :create
  validates_numericality_of :cost, :on => :update
  #validates_numericality_of :order_number, :on => :update
  
  def self.call_a_taxi(params)
    # этот метод должен отправлять post-запрос на сервер заказа такси и возвращать результат - номер заказа
    #order_number = Net::HTTP.post_form(URI.parse('http://www.2212212.ru/onlajn_zakaz_taksi.htm'), params)
    order_number = 1000000 + rand(1000000)
    return order_number
  end
  
  def self.add_request(params, employee_id, order_number)
    # этот метод создает объект класса Taxirequest и сохраняет его в БД
    taxirequest = self.new(params)
    taxirequest.employee_id = employee_id
    taxirequest.order_number = order_number
    return taxirequest
  end
  
end
