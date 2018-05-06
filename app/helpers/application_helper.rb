module ApplicationHelper
  def render_user_auth_nav
    if current_user
      render 'signed_in'
    else
      render 'signed_out'
    end
  end
end
