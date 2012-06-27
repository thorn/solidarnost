require "spec_helper"

describe ApplicationHelper do
  describe "methods" do
    it "should get selected options for group" do
      @gr = FactoryGirl.create(:group)
      @gr_op1 = FactoryGirl.create(:group_option, group_id: @gr.id, name: "go_1")
      @gr_op2 = FactoryGirl.create(:group_option, group_id: @gr.id, name: "go_2")
      @family = double('family')
      @family.stub(:group_options).and_return([@gr_op1])
      group_options_for_select(@gr, @family).should == "<option value=\"#{@gr_op2.id}\">go_2</option><option selected=\"selected\" value=\"#{@gr_op1.id}\">go_1</option>"
    end
  end
end
