# Store the relationship between UUID and ActiveRecord instance
class Uuidify::Uuid < ActiveRecord::Base
  if Rails::VERSION::MAJOR == 3
    attr_accessible :model_name, :model_id, :model_uuid
  end
end
