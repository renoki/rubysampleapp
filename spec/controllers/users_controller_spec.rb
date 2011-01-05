require 'spec_helper'

describe UsersController do

  render_views

  describe "GET 'show'" do

    before(:each) do
        @user = Factory(:user)
    end

    it "should be success" do
        get :show, :id => @user
        response.should be_success
    end

    it "should find the right user" do
        get :show, :id => @user

        assigns(:user).should   == @user
    end

    it "should have a profile image" do
        get :show, :id => @user
        response.should have_selector("h1>img", :class=>"gravatar")
    end

  end



end
