require 'spec_helper'

describe News do
  before(:each) do
    @attr = {title: "title", text: "text"}
    @news1 = News.create!(@attr)
    @news2 = News.create!(@attr)
  end
  describe "methods" do
    it "should mark news as read" do
      expect{@news1.read!}.to change{@news1.status}.from(0).to(1)
    end
  end
end
