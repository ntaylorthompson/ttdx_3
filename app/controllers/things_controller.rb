class ThingsController < ApplicationController
  before_action :set_thing, only: [:show, :edit, :update, :destroy]
  
  
  # GET /things
  # GET /things.json
  def index
    if params[:tag]
      @things = Thing.tagged_with(params[:tag]).order('updated_at DESC')
    else
      @things = Thing.all.order('updated_at DESC')
    end
  end
  
  def index_current_user
    @things = current_user.things.order('updated_at DESC')
    @followed_things = current_user.followed_things
    
  end
  # GET /things/1
  # GET /things/1.json

  def follow
    id_s = params[:format]
    id = id_s.to_i
    current_user.followed_things_will_change!
    if current_user.followed_things.nil? 
      current_user.update_attribute(:followed_things, [id])
    else
      unless current_user.followed_things.include? id_s
        current_user.update_attributes(followed_things: current_user.followed_things.push(id))
      end
    end
    current_user.save
    redirect_to things_path    
  end

  #NEEDSTO BE FIXED 
  def show
    #ALREADY HAS @THING AUTOMATICALLY, SO MAYBE NEXT LINE IS UNNECESSARY?
#    @solution = @thing.solutions.first
  end

  # GET /things/new
  def new
    @thing = Thing.new
    1.times {@thing.solutions.build}
  end



  # POST /things
  # POST /things.json
  def create
    @thing = current_user.things.build(thing_params)
#    @thing.solutions.build(solution_params)
#    @solutions = @thing.solutions
        
    if params[:add_solution]
      @thing = current_user.things.build(thing_params)
      @thing.solutions.build
      render :new
      return
    end
 #     new_sol = Solution.new
  #    @thing.solutions.build
   #   @solutions = @thing.solutions
#    else
#    respond_to do |format|
      if @thing.save
        flash[:notice] = "Successfully created thing."
        redirect_to @thing and return
      else
        format.html { render :new }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
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

   end
  #end



  



  # GET /things/1/edit  
  def edit
  end

  # PATCH/PUT /things/1
  # PATCH/PUT /things/1.json
  def update
    if params[:add_solution]
      @thing = Thing.find(params[:id])
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
      params.require(:thing).permit(:user_id, :object_description, :problem_description, :solution_description, :tag_list,  solutions_attributes: [:id, :kind, :description, :issues_description ])
#      params.require(:solution).permit(:kind, :description, :issues_description)
    end
    def solution_params
      params.require(:solution).permit(:id, :kind, :description, :issues_description)
    end

  end