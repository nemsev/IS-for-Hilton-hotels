class AddAttachmentPictureToEmployees < ActiveRecord::Migration
  def self.up
    change_table :employees do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :employees, :picture
  end
end
