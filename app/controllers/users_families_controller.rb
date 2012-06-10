class UsersFamiliesController < ApplicationController
  def destroy
    @userfamily = UsersFamily.find(params[:id])
    @fam = @userfamily.family
    if @userfamily.destroy
      if params[:user_id] != nil
        redirect_to admin_user_path(params[:user_id])
      else
        redirect_to family_path(@fam)
      end
    end
  end
end
