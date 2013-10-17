Uuidify
=======

Add UUIDs to existing ActiveRecord models.

To install:

    rake uuidify:install:migrations
    rake db:migrate

To enable on a specific model:

    class Foo < ActiveRecord::Base
      uuidify
    end

To get/set uuids:

    Foo.new.uuid
    Foo.new.uuid = UUIDTools::UUID.timestamp_create

 To gc orphan records:

    Foo.garbage_collect_uuids # single model
    Uuidify.garbage_collect_uuids # everything, even if the model doesn't exist in the source

Software Verification
---------------------

This gem is signed with
[rubygems-openpgp](https://github.com/grant-olson/rubygems-openpgp).
You can verify its integrity by running:

    gem install uuidify --verify

Signing key:

    pub   2048R/E3B5806F 2010-01-11 [expires: 2014-01-03]
          Key fingerprint = A530 C31C D762 0D26 E2BA  C384 B6F6 FFD0 E3B5 806F
    uid                  Grant T. Olson (Personal email) <kgo@grant-olson.net>
    uid                  Grant T Olson <grant@webkite.com>
    uid                  Grant T. Olson (pikimal) <grant@pikimal.com>
    sub   2048R/6A8F7CF6 2010-01-11 [expires: 2014-01-03]
    sub   2048R/A18A54D6 2010-03-01 [expires: 2014-01-03]
    sub   2048R/D53982CE 2010-08-31 [expires: 2014-01-03]