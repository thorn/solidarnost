class ChildrenController < ApplicationController
  before_filter :find_child

  def show
  end


  def destroy
    @child.destroy
    redirect_to children_url
  end

  def find_child
    @child = Child.find(params[:id])
  end

end
