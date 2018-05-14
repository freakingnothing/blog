class AvatarsController < ApplicationController
  def destroy
    @user = current_user
    @avatar = @user.avatar
    @avatar.purge
    redirect_to auth_user_path(@user)
  end
end
