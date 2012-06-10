class GroupsController < ApplicationController

  before_filter :find_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(params[:group])

    if @group.save
      redirect_to groups_path, notice: 'Group was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @group.update_attributes(params[:group])
      redirect_to groups_path
    else
      render action: "edit"
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url
  end

  private
    def find_group
      @group = Group.find(params[:id])
    end
end
