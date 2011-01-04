require 'spec_helper'

describe User do
    before(:each) do
        @attr = { :name => "Example User", :email=>"user@example.com"}
    end

    it "should create a new instance given valid attribute" do
        User.create(@attr)
    end

    it "should require a name" do
        no_name_user = User.new(@attr.merge(:name=>""))
        no_name_user.should_not be_valid
    end

    it "should not have duplicates" do
        User.create(@attr)  
        dup_name = User.new(@attr);
        dup_name.should_not be_valid
    end
end
