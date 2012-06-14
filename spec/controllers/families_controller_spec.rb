require "spec_helper"

describe FamiliesController do
  render_views

  describe "GET 'index'" do

  end

  describe "POST" do
    describe 'success' do
      it "should create a new Family" do
        lambda do
          opt = Factory(:group_option)
          @attr = {:title => "me", :source_id => opt.id, :resource_id => opt.id, :home_id => opt.id}
          post :create, :family => @attr
        end.should change(Family, :count).by(1)
      end

    end

    describe "failure" do
      it "should not create family" do
        lambda do
          post :create, :family => {:name => ""}
        end.should raise_error(NoMethodError)
      end
    end
  end
end
