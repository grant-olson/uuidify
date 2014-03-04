# Store the relationship between UUID and ActiveRecord instance
class Uuidify::Uuid < ActiveRecord::Base
  if Rails::VERSION::MAJOR == 3
    attr_accessible :model_name, :model_id, :model_uuid
  end

  def self.uuid_storage_type
    connection.adapter_name == "PostgreSQL" ? :string : :binary
  end
  
  def self.uuid_to_sql_string uuid
    if uuid_storage_type == :string
      uuid.to_s
    else
      uuid.raw
    end
  end

  def self.uuid_from_sql_string string
    if uuid_storage_type == :string
      UUIDTools::UUID.parse(string)
    else
      UUIDTools::UUID.parse_raw(string)
    end
  end
  
end
