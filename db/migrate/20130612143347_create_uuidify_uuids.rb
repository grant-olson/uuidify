class CreateUuidifyUuids < ActiveRecord::Migration
  def up
    uuid_type = connection.adapter_name == "PostgreSQL" ? :string : :binary

    create_table :uuidify_uuids do |t|
      t.string :model_name
      t.integer :model_id

      if uuid_type == :string
        t.string :model_uuid, :limit => 36
      end
      
    end

    if uuid_type == :binary
      execute "ALTER TABLE uuidify_uuids ADD COLUMN model_uuid BINARY(16)"
    end

    add_index :uuidify_uuids, [:model_name, :model_id], :unique => true
    add_index :uuidify_uuids, :model_uuid, :unique => true
    add_index :uuidify_uuids, [:model_uuid, :model_id], :unique => true
  end

  def down
    drop_table :uuidify_uuids
  end
end
