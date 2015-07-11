class ThingsController < ApplicationController
  before_action :set_thing, only: [:show, :edit, :update, :destroy]




#stuff taylor added

#not sure if I should adjust the current user index to use tags?
  def current_user_index
    @things = current_user.things    
  end
  
  
  #generated stuff
  
  # GET /things
  # GET /things.json
  def index
    if params[:tag]
      @things = Thing.tagged_with(params[:tag])
    else
      @things = Thing.all
    end
  end

  # GET /things/1
  # GET /things/1.json
  def show
    @solution = @thing.solutions.first
  end

  # GET /things/new
  def new
    @thing = Thing.new
    @solution = Solution.new
  end

  # GET /things/1/edit
  
  def edit
    @solution = Thing.find(params[:id]).solutions.first
  end

  # POST /things
  # POST /things.json
  def create
    @thing = current_user.things.build(thing_params)
    @solution = @thing.solutions.build(solution_params)
    
    respond_to do |format|
      if @thing.save
        format.html { redirect_to @thing, notice: 'Thing was successfully created.' }
        format.json { render :show, status: :created, location: @thing }
      else
        format.html { render :new }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
      if @solution.save
        format.html { redirect_to @solution, notice: 'Solution was successfully created.' }
        format.json { render :show, status: :created, location: @solution }
      else
        format.html { render :new }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /things/1
  # PATCH/PUT /things/1.json
  def update
    respond_to do |format|
      if @thing.update(thing_params)
        format.html { redirect_to @thing, notice: 'Thing was successfully updated.' }
        format.json { render :show, status: :ok, location: @thing }
      else
        format.html { render :edit }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
      if Thing.find(params[:id]).solutions.first.update(solution_params)
        format.html { redirect_to @solution, notice: 'Thing was successfully updated.' }
        format.json { render :show, status: :ok, location: @solution }
      else
        format.html { render :edit }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
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
      params.require(:thing).permit(:user_id, :object_description, :problem_description, :solution_description, :tag_list)
    end
    def solution_params
      params.require(:solution).permit(:kind, :description, :issues_description)
    end
end
