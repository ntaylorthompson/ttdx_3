class ApplicationController < ActionController::Base
  include PublicActivity::StoreController


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :reject_locked!, if: :devise_controller?


  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :email,
      :password,
      :password_confirmation,
      :new_signup_thing_id
      )
    }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
      :email,
      :password,
      :password_confirmation,
      :current_password
      )
    }
  end

  # Redirects on successful sign in
  def after_sign_in_path_for(resource)
    new_thing_path
  end

  # Auto-sign out locked users
  def reject_locked!
    if current_user && current_user.locked?
      sign_out current_user
      user_session = nil
      current_user = nil
      flash[:alert] = "Your account is locked."
      flash[:notice] = nil
      redirect_to root_url
    end
  end
  helper_method :reject_locked!

  # Only permits admin users
  def require_admin!
    authenticate_user!
    if current_user && !current_user.admin?
      redirect_to root_path
    end
  end

  helper_method :require_admin!

  # Only permits signed_in users

  def require_signed_in!
    if !user_signed_in?
      redirect_to new_user_registration_path
      flash[:alert] = "You need to sign in or sign up before continuing."
    end
  end
  helper_method :require_signed_in!


  def require_owner!(object)
    unless object.user == current_user
      redirect_to :back
      flash[:alert] = "You can only edit things that you own."
    end
  end

  helper_method :require_owner!

end
