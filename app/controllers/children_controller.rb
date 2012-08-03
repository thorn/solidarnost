class ChildrenController < ApplicationController
  before_filter :find_child

  def show
  end


  def destroy
    @family = @child.destroy.family
    redirect_to family_path(@family)
  end

  def find_child
    @child = Child.find(params[:id])
  end

end
