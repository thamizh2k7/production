class AddAttachmentImageToGeneralImages < ActiveRecord::Migration
  def self.up
    change_table :general_images do |t|
      t.has_attached_file :image
    end
  end

  def self.down
    drop_attached_file :general_images, :image
  end
end
