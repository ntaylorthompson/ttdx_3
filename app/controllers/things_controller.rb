class ThingsController < ApplicationController
#  before_filter :require_signed_in!, unless: :user_not_required?
  before_action :set_thing, only: [:show, :edit, :update, :destroy]

  def home_alt
    @thing = Thing.new
#    @user.things.build
#    @thing.user_not_required == true     
  end  
  
  # GET /things
  # GET /things.json
  def index
    if params[:tag]
      @things = Thing.tagged_with(params[:tag]).page params[:page]
    else
      @things = Thing.all.search_and_order(params[:search], params[:page])
    end
    @followed_things_ids = current_user.followed_things.map(&:to_i)
  end
  
  def index_current_user
    @things = current_user.things
    ft = current_user.followed_things
    ft = Thing.find(ft)
    @followed_things = ft
    @followed = false
    
  end
  # GET /things/1
  # GET /things/1.json

  def follow
    id_s = params[:format]
    id = id_s.to_i
    current_user.followed_things_will_change!
    if current_user.followed_things.nil? 
      current_user.update_attribute(:followed_things, [id])
      current_user.create_activity :thing_followed, owner: current_user
    else
      unless current_user.followed_things.include? id_s
        current_user.update_attributes(followed_things: current_user.followed_things.push(id))
        #set target type to the object being followed
        current_user.create_activity action: 'thing_followed', owner: current_user, relevant_obj_id: id
      end
    end
    current_user.save
    redirect_to things_path    
  end
  
  def unfollow
    id_s = params[:format]
    id = id_s.to_i
    current_user.followed_things_will_change!
    current_user.followed_things.delete(id_s)
    current_user.save


    redirect_to(:back)    
  end
    

  #NEEDSTO BE FIXED 
  def show
    if @thing.user.nil?
      u = User.new
      u.username = "anonymous"
      @thing.user = u 
    end
    @comments = @thing.comments

    #ugh: needed to create a new comment without adding new comment to the list at bottom of thing view
    @comment = Comment.new
    @comment.thing_id = @thing.id
    @comment.user = current_user
  end

  # GET /things/new
  def new
    @thing = Thing.new
    1.times {@thing.solutions.build}
  end



  # POST /things
  # POST /things.json
  def create
    if current_user.soft_user?
      @thing = Thing.new(thing_params)   
      @thing.solutions.build     
      if params[:signup]
        @thing.soft_token = current_user.soft_token
        if @thing.save
          flash[:notice]= ['Your need was created.','Sign up to get alerts on solutions!'].join("<br/><br/>").html_safe
          redirect_to controller: "users/registrations", action: "new"
        end
      else
        @thing.soft_token = current_user.soft_token        
        if params[:add_solution]
          @thing = current_user.things.build(thing_params)
          @thing.solutions.build
          render :new
          return
        end
        respond_to do |format|
          if @thing.save
            format.html { redirect_to new_user_registration_path, notice: 'Thing was successfully created.' }
            format.json { render :show, status: :created, location: @thing }
          else
            format.html { render :new  }
            format.json { render json: @thing.errors, status: :unprocessable_entity }
          end
        end
      end

# IF USER IS NOT SOFT USER
    else
      @thing = current_user.things.build(thing_params)  
      if params[:signup] or params[:action] == "home_alt"
        @thing.solutions.build
        # if @thing.save
        #   flash[:notice]= ['Your need was created.','Fill out more details here!'].join("<br/><br/>").html_safe
        #   render :edit and return
        # else
        #   redirect_to :back, alert: "Thing not created, go go 'new thing' view!"
        # end
        respond_to do |format|
          if @thing.save
            format.html { redirect_to new_thing_path, notice: 'Thing was successfully created.' }
            format.json { render :show, status: :created, location: @thing }
          else
            format.html { render :home_alt }
            format.json { render json: @thing.errors, status: :unprocessable_entity }
          end
        end
      else
        if params[:add_solution]
          @thing.solutions.build
          render :new and return
        end
        @thing.solutions.build
        respond_to do |format|
          if @thing.save
            format.html { redirect_to new_thing_path, notice: 'Thing was successfully created.' }
            format.json { render :show, status: :created, location: @thing }
          else
            format.html { render :new  }
            format.json { render json: @thing.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end
   #     if @solution.save
    #      format.html { redirect_to @solution, notice: 'Solution was successfully created.' }
     #     format.json { render :show, status: :created, location: @solution }
     #   else
      #    format.html { render :new }
       #   format.json { render json: @solution.errors, status: :unprocessable_entity }
       # end
       # => @thing.save
  #     @thing.save    
   #    render :edit
  #end



  



  # GET /things/1/edit  
  def edit
    #refactor w/ udpate to separate method
    unless current_user.id == Thing.find(params[:id]).user_id
      flash[:alert] = "You can only edit your own things!"
      redirect_to(:back) and return 
    end
    @thing.solutions.build if @thing.solutions.empty?
    
  end

  # PATCH/PUT /things/1
  # PATCH/PUT /things/1.json
  def update
    #refactor w/ edit to separate method
    unless current_user.id == Thing.find(params[:id]).user_id
      flash[:alert] = "You can only edit your own things!"
      redirect_to(:back) and return 
    end    
    if params[:add_solution]
      @thing = Thing.find(params[:id])
      @thing.update(thing_params)
      @thing.solutions.build
      render :edit
      return
    end
    respond_to do |format|
      if @thing.update(thing_params)
        format.html { redirect_to @thing, notice: 'Thing was successfully updated.' }
        format.json { render :show, status: :ok, location: @thing }
      else
        format.html { render :edit }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end

    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def destroy
    before_filter :require_admin! #FOR NOW, DON'T WANT PEOPLE TO DESTROY THINGS
    @thing.destroy
    respond_to do |format|
      format.html { redirect_to things_url, notice: 'Thing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thing
      @thing = Thing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thing_params
      params.require(:thing).permit(:user_id, :object_description, :problem_description, :solution_description, :tag_list, :user_not_required,  solutions_attributes: [:id, :kind, :description, :issues_description, :link])
#      params.require(:solution).permit(:kind, :description, :issues_description)
    end

   
      

  end