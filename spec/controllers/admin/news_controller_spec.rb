require "spec_helper"

describe Admin::NewsController do
  describe "get 'mark as read'" do
    before(:each) do
      @news1 = FactoryGirl.create(:news)
      @news2 = FactoryGirl.create(:news)
    end

    it "should mark appropriate as read" do
      expect{get :mark_as_read, to_read: @news1.id}.to change{@news1}
    end
  end
end
