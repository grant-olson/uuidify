class CreateUuidifyUuids < ActiveRecord::Migration
  def up
    create_table :uuidify_uuids do |t|
      t.string :model_name
      t.integer :model_id
#      t.string :model_uuid, :limit => 36
    end
    
    execute "ALTER TABLE uuidify_uuids ADD COLUMN model_uuid BINARY(16)"
    add_index :uuidify_uuids, [:model_name, :model_id], :unique => true
    add_index :uuidify_uuids, :model_uuid, :unique => true
    add_index :uuidify_uuids, [:model_uuid, :model_id], :unique => true
  end

  def down
    drop_table :uuidify_uuids
  end
end
