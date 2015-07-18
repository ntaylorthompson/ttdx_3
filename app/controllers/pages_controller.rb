class PagesController < ApplicationController

  def home
    redirect_to new_thing_path if current_user.present?
  end

  def inside
  end
  


  private

  def sign_up_params
    params.require(:user).permit!
  end

  def account_update_params
    params.require(:user).permit!
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end  
  
  
end
