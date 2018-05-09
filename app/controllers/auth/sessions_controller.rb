# frozen_string_literal: true

class Auth::SessionsController < Auth::BaseController
  def new; end

  def create
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      if @user.email_confirmed
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash[:warning] = 'Please activate your account by following the instructions in the account confirmation email.'
        render 'new'
      end
    else
      flash[:danger] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
