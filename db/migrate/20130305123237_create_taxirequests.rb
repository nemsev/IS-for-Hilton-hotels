class CreateTaxirequests < ActiveRecord::Migration
  def change
    create_table :taxirequests do |t|
      t.integer :order_number
      t.string :payment_method
      t.integer :cost
      t.integer :room
      t.string :destination
      t.date :arrival_date
      t.time :arrival_time
      t.string :guest_name
      t.references :employee
      
      t.timestamps
    end
    add_index :taxirequests, :employee_id
  end
end
