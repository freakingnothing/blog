class Auth::UserMailer < ApplicationMailer
  def register_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to the site!')
  end
end
