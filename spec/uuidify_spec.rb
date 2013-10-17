require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'uuidtools'

describe "uuidify" do
  it "returns a uuid" do
    foo = Foo.create
    lambda {foo.uuid}.should_not raise_error
  end
  
  it "returns a valid uuid" do
    foo = Foo.create
    foo.uuid.should be_a UUIDTools::UUID
  end
  
  it "persists the uuid" do
    foo = Foo.create
    original_uuid = foo.uuid
    foo.uuid.should == original_uuid
  end

  it "won't generate a uuid on an unsaved object" do
    foo = Foo.new
    lambda{foo.uuid}.should raise_error(Uuidify::UuidifyException)
  end

  it "finds model by uuid" do
    foo = Foo.create
    uuid = foo.uuid
    new_foo = Foo.lookup_uuid(uuid)
    new_foo.should == foo
  end
  
  it "doesn't find the wrong model" do
    foo = Foo.create
    bad_uuid = UUIDTools::UUID.timestamp_create
    Uuidify::Uuid.create(:model_name => "Baz", :model_id => foo.id, :model_uuid => bad_uuid)
    Foo.lookup_uuid(bad_uuid).should be_nil
  end

  it "destroys entry when destroying model" do
    foo = Foo.create
    uuid = foo.uuid
    foo.destroy
    Foo.lookup_uuid(uuid).should be_nil
  end

  it "raises error for orphan entry" do
    foo = Foo.create
    uuid = foo.uuid
    foo.delete
    lambda{Foo.lookup_uuid(uuid)}.should raise_error(ActiveRecord::RecordNotFound)
  end
  
  it "Only works when explicitly activated" do
    bar = Bar.create
    lambda {bar.uuid}.should raise_error
  end

  context "garbage collector" do
    let(:foo1) { Foo.create }
    let(:foo2) { Foo.create }
    let(:foo3) { Foo.create }

    before :each do
      # force generation of uuids
      foo1.uuid;foo2.uuid;foo3.uuid
    end
    
    it "should sweep up orphans" do
      foo1_uuid = foo1.uuid
      foo1.delete

      Foo.garbage_collect_uuids
      Foo.lookup_uuid(foo1_uuid).should be_nil
    end
    
    it "shouldn't sweep up non-orphans" do
      foo2_uuid = foo2.uuid
      foo1.delete

      Foo.garbage_collect_uuids
      Foo.lookup_uuid(foo2_uuid).should_not be_nil
    end

    it "has global gc" do
      foo3_uuid = foo3.uuid
      foo3.delete
      
      Uuidify.garbage_collect_uuids

      Foo.lookup_uuid(foo2.uuid).should_not be_nil
      Foo.lookup_uuid(foo3_uuid).should be_nil
    end
    
    it "has global gc that handles orphaned CLASSES" do
      foo1_uuid = foo1.uuid

      Uuidify::Uuid.create(:model_name => "NonexistantClass", :model_id => 1, :model_uuid => UUIDTools::UUID.timestamp_create)
      Uuidify.garbage_collect_uuids

      Uuidify::Uuid.where(:model_name => "NonexistantClass").should be_empty
      Foo.lookup_uuid(foo1_uuid).should_not be_nil
    end
    

  end

  it "can force a uuid" do
    new_uuid = UUIDTools::UUID.timestamp_create
    foo = Foo.create
    foo.uuid = new_uuid

    Foo.lookup_uuid(new_uuid).should == foo
  end
  
  it "can force a new uuid over an existing one" do
    foo = Foo.create
    existing_uuid = foo.uuid

    new_uuid = UUIDTools::UUID.timestamp_create
    foo.uuid = new_uuid

    Foo.lookup_uuid(new_uuid).should == foo
    Foo.lookup_uuid(existing_uuid).should be_nil
  end
  
  
end
