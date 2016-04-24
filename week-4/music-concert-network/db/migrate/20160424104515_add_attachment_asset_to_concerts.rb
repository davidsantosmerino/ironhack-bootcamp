class AddAttachmentAssetToConcerts < ActiveRecord::Migration
  def self.up
    change_table :concerts do |t|
      t.attachment :asset
    end
  end

  def self.down
    remove_attachment :concerts, :asset
  end
end
