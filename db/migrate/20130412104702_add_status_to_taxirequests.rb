class AddStatusToTaxirequests < ActiveRecord::Migration
  def change
    add_column :taxirequests, :status, :integer, :default => 0
  end
end
