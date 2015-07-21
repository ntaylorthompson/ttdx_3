class Users::RegistrationsController < Devise::RegistrationsController
 before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  
  
#   def home_alt
#     @thing = Thing.new
# #    @user.things.build
# #    @thing.user_not_required == true
#   end
#
  
  # def merge_things
  #   things = Thing.where(soft_token: current_user.soft_token)
  #   things.map do |thing|
  #     thing.user = current_user
  #     thing.user_id = current_user.id
  #     thing.save!
  #   end
  # end
  
  # GET /resource/sign_up
  def new
    build_resource({})
    self.resource.things.build
    respond_with self.resource
  end

 
  # POST /resource
  # BOTCHED ATTEMPT TO CUSTOMIZE DEVISE REGISTRATIONS#CREATE CONTROLLER


   # def create
   #   if params[:signup] == "post your need to startups >"
   #     user = User.new
   #   end
   #
   #   super do |resource|
   #      BackgroundWorker.trigger(resource)
   #   end
   #  end
   def create
     super
   end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :soft_token
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, things_attributes: [:id, :object_description])
  end

  # def landing_page_params
  #   params.require(thing:).permit(:object_description, :tag_list)
  # end

  def account_update_params
    params.require(:user).permit!
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end  


  # The path used after sign up.
  def after_sign_up_path_for(resource)
    # merge_things
    # super(resource)
    flash[:notice] = "Add more detail to your need, to help us search the future!"
    edit_thing_path(current_user.things.first)
    
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  
  
  
end
