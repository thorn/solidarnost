class Admin::FundsController < Admin::BaseController
before_filter :find_fund, only: [:show, :edit, :update, :destroy]

  def index
    @funds = Fund.all
  end

  def show
  end

  def new
    @fund = Fund.new
  end

  def edit
  end

  def create
    @fund = Fund.new(params[:fund])

    if @fund.save
      redirect_to admin_funds_path, notice: 'Fund was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @fund.update_attributes(params[:fund])
      redirect_to admin_funds_path, notice: 'Fund was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @fund.destroy
    redirect_to admin_funds_path
  end

  private
    def find_fund
      @fund = Fund.find(params[:id])
    end
end
