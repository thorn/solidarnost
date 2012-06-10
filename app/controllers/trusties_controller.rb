class TrustiesController < ApplicationController
  def show
    @trusty = Trusty.find(params[:id])
  end

  def destroy
    @trusty = Trusty.find(params[:id])
    @fam = @trusty.destroy.family

    redirect_to family_path(@fam)
  end
end
