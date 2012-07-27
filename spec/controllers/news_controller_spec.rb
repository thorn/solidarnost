require "spec_helper"

describe Admin::NewsController do
  describe "get 'mark as read'" do
    before(:each) do
      @news1 = FactoryGirl.create(:news)
      @news2 = FactoryGirl.create(:news)
    end

    it "should mark appropriate as read" do
      get :mark_as_read, ids: [@news1.id, @news2.id]
      @news1.reload
      @news1.status.should == 1
    end
  end
end
