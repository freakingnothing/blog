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

  def confirm_email
    @user = User.find_by_confirmation_token(params[:token])
    if @user
      @user.email_active
      @user.save(validate: false)
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "Your email is already confirmed."
      redirect_to login_path
   end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end
end
