# frozen_string_literal: true

class Auth::UsersController < Auth::BaseController
  def show
    @user = User.friendly.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      Auth::UserMailer.with(user: @user).register_email.deliver_now
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path
    else
      flash[:danger] = 'Current password is incorrect.'
      render 'edit'
    end
  end

  def confirm_email
    @user = User.find_by_confirmation_token(params[:token])
    if @user
      @user.email_active
      @user.save(validate: false)
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = 'Your email is already confirmed.'
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :current_password, :password, :password_confirmation)
  end
end
