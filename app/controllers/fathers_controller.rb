class FathersController < ApplicationController
  def show
    @father = Father.find(params[:id])
  end

  def destroy
    @father = Father.find(params[:id])
    @fam = @father.destroy.family
    redirect_to family_path(@fam)
  end
end
