class CreateStationeryrequests < ActiveRecord::Migration
  def change
    create_table :stationeryrequests do |t|
      t.integer :status
      t.references :employee
      
      t.timestamps
    end
    add_index :stationeryrequests, :employee_id
  end
end
