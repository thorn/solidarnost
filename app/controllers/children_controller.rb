class ChildrenController < ApplicationController
  def index
    @children = Child.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @children }
    end
  end

  def show
    @child = Child.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @child }
    end
  end

  def new
    @child = Child.new

    respond_to do |format|
      format.html
      format.json { render json: @child }
    end
  end

  def edit
    @child = Child.find(params[:id])
  end

  def create
    @child = Child.new(params[:child])

    respond_to do |format|
      if @child.save
        format.html { redirect_to @child, notice: 'Child was successfully created.' }
        format.json { render json: @child, status: :created, location: @child }
      else
        format.html { render action: "new" }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @child = Child.find(params[:id])

    respond_to do |format|
      if @child.update_attributes(params[:child])
        format.html { redirect_to family_path(@child.family), notice: 'Child was successfully updated.' }
        format.json { respond_with_bip(@child) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@child)}
      end
    end
  end

  def destroy
    @child = Child.find(params[:id])
    @child.destroy

    respond_to do |format|
      format.html { redirect_to children_url }
      format.json { head :ok }
    end
  end
end
