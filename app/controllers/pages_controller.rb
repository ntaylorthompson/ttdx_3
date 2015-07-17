class PagesController < ApplicationController

  def home
    redirect_to new_thing_path if current_user.present?
  end

  def inside
  end
  
  def home_alt

    @submission = Thing.new
  end
  
end
