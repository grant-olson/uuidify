# = Uuidify
#
# Add UUIDs to existing ActiveRecord models.
#
# To install:
# 
#    rake uuidify:install:migrations
#    rake db:migrate
#
# To enable on a specific model:
#
#    class Foo < ActiveRecord::Base
#      uuidify
#    end
#
# To get/set uuids:
#
#    Foo.new.uuid
#    Foo.new.uuid = UUIDTools::UUID.timestamp_create
#
# To gc orphan records:
#
#    Foo.garbage_collect_uuids # single model
#    Uuidify.garbage_collect_uuids # everything, even if the model doesn't exist in the source
