class GroupOptionsController < ApplicationController
  # GET /group_options
  # GET /group_options.json
  def index
    @group_options = GroupOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_options }
    end
  end

  # GET /group_options/1
  # GET /group_options/1.json
  def show
    @group_option = GroupOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_option }
    end
  end

  # GET /group_options/new
  # GET /group_options/new.json
  def new
    @group_option = GroupOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_option }
    end
  end

  # GET /group_options/1/edit
  def edit
    @group_option = GroupOption.find(params[:id])
  end

  # POST /group_options
  # POST /group_options.json
  def create
    @group_option = GroupOption.new(params[:group_option])

    respond_to do |format|
      if @group_option.save
        format.html { redirect_to group_options_path, notice: 'Group option was successfully created.' }
        format.json { render json: @group_option, status: :created, location: @group_option }
      else
        format.html { render action: "new" }
        format.json { render json: @group_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_options/1
  # PUT /group_options/1.json
  def update
    @group_option = GroupOption.find(params[:id])

    respond_to do |format|
      if @group_option.update_attributes(params[:group_option])
        format.html { redirect_to group_options_path, notice: 'Group option was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@group_option) }
      end
    end
  end

  # DELETE /group_options/1
  # DELETE /group_options/1.json
  def destroy
    @group_option = GroupOption.find(params[:id])
    @group_option.destroy

    respond_to do |format|
      format.html { redirect_to group_options_url }
      format.json { head :ok }
    end
  end
end
