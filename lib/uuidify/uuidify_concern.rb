require 'uuidtools'
require 'active_support/concern'
require_relative 'uuidify_exception'

# Mixin to add uuids to an active record model.
module Uuidify::UuidifyConcern
  extend ActiveSupport::Concern
  
  included do
    before_destroy :destroy_uuid

    scope :with_raw_uids, -> {
      joins("INNER JOIN uuidify_uuids ON uuidify_uuids.model_id = #{self.table_name}.id").
      where("uuidify_uuids.model_name = '#{self.name}'").
      select("#{self.table_name}.*, uuidify_uuids.model_uuid AS raw_uid")
    }
  end

  module ClassMethods
    # .find_by_uuid.  Used lookup so we know it's not rails magic.
    def lookup_uuid(uuid)
      uuid = Uuidify::Uuid.uuid_to_sql_string(uuid)
      
      uuid = Uuidify::Uuid.where(:model_uuid => uuid, :model_name => self.to_s).first
      uuid ? find(uuid.model_id) : nil
    end

    # Delete entries where we don't have a model that can be instantiated anymore.
    def garbage_collect_uuids
      Uuidify::Uuid.where(:model_name => self.to_s).find_each do |uuid|
        if !where(:id => uuid.model_id).first
          uuid.destroy
        end
      end
    end


  end

  # Return a UUID, creating it if needed.
  def uuid
    abort_if_unsaved!

    model_name = self.class.to_s
    model_id = self.id

    uuid = Uuidify::Uuid.where(:model_name => model_name, :model_id => model_id).first

    if uuid.nil?
      new_uuid = UUIDTools::UUID.timestamp_create
      new_uuid = Uuidify::Uuid.uuid_to_sql_string(new_uuid)

      uuid = Uuidify::Uuid.create(:model_name => model_name, :model_id => self.id, :model_uuid => new_uuid)
      uuid.save!
    end

    Uuidify::Uuid.uuid_from_sql_string(uuid.model_uuid)
  end


  # Assign a UUID that came from an external source.
  def uuid= new_uuid
    abort_if_unsaved!

    uuid_value = Uuidify::Uuid.uuid_to_sql_string(new_uuid)
    
    Uuidify::Uuid.where(:model_name => self.class.to_s, :model_id => self.id).first_or_create!.update_column(:model_uuid, uuid_value)
  end
  
  private

  def abort_if_unsaved!
    if self.id.nil?
      raise Uuidify::UuidifyException, "This model hasn't been persisted yet and Uuidify doesn't want to implicitly do that.  Won't create uuid"
    end
  end

  def destroy_uuid
    model_name = self.class.to_s
    model_id = self.id
    uuid = Uuidify::Uuid.where(:model_name => model_name, :model_id => model_id).first
    uuid.destroy if uuid
  end
end

