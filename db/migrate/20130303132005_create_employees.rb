class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :employee
      t.string :password
      t.string :salt
      t.string :position
      t.references :company

      t.timestamps
    end
    add_index :employees, :company_id
  end
end
