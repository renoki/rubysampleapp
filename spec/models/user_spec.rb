require 'spec_helper'

describe User do
    before(:each) do
        @attr = { :name => "Example User", 
                    :email=>"user@example.com",
                    :password => "foobar",
                    :password_confirmation => "foobar"}
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


    describe "password validations" do
        it "should require password" do
            need_pw = User.new(@attr.merge(:password=>"", 
                                 :password_confirmation=>""))
            need_pw.should_not be_valid
        end

        it "passwords should match " do
            pass_match = User.new(@attr.merge(:password_confirmation=>"invalid"))
            pass_match.should_not be_valid
        end

        it "should reject shortpasswords" do
            short = "a" * 5
            pass_len = User.new(@attr.merge(
                :password=>short, 
                :password_confirmation=>short))
            pass_len.should_not be_valid
        end
    
    end

    describe "password encryption" do
        before(:each) do
            @user = User.create!(@attr)
        end

        it "should have encryption" do
            @user.should respond_to(:encrypted_password)
        end

        it "should set encrypted password" do
            @user.encrypted_password.should_not be_blank
        end

        describe "has_password? method" do
            it "should have passwords match" do
                @user.has_password?(@attr[:password]).should be_true
            end

            it "should be false if passwords do not match" do
                @user.has_password?(@attr["invalid"]).should be_false
            end
        end
    end

    
end
