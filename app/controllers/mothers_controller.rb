class MothersController < ApplicationController
  def show
    @mother = Mother.find(params[:id])
  end

  def destroy
    @mother = Mother.find(params[:id])
    @fam = @mother.destroy.family

    redirect_to family_path(@fam)
  end
end
