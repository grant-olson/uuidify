require 'uuidify/engine'
require 'uuidify/uuidify_concern'

# Helper like acts_as_X so we don't deal with the concern mixin directly.
def uuidify
  include Uuidify::UuidifyConcern
end

module Uuidify
  # Clean up all orphaned and useless UUIDs in the database, whether or not we can
  # resolve them to a class.
  def self.garbage_collect_uuids
    Uuidify::Uuid.select("model_name").group("model_name").each  do |m|
      begin
        klass = m.model_name.constantize
        klass.garbage_collect_uuids
      rescue NameError => ex # Class that doesn't exist in current project
        Uuidify::Uuid.where(:model_name => m.model_name).delete_all
      end
    end
  end
end
