class FamilyMembersController < ApplicationController
  before_filter :find_family_member

  def show
  end


  def destroy
    @family = @family_member.destroy.family
    redirect_to family_path(@family)
  end

  def find_family_member
    @family_member = FamilyMember.find(params[:id])
  end

end
