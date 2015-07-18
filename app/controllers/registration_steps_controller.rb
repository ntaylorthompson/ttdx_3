class RegistrationStepsController < ApplicationController

  include Wicked::Wizard
  steps :first_thing, :sign_up
  
  def show
    render_wizard
  end
  
  
end
