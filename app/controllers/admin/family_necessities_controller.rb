class FamilyNecessitiesController < ApplicationController
  def destroy
    @nec = FamilyNecessity.find(params[:id])
    @f = @nec.family
    @nec.destroy
    redirect_to @f
  end
end
