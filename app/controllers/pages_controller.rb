class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
    redirect_to new_thing_path if current_user.present?
  end

  def inside
  end
  
  
end
