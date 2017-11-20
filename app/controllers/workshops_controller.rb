class WorkshopsController < ApplicationController
  before_action :set_workshop, only: [:show]

  # GET /workshops
  # GET /workshops.json
  def index
    @workshops = Workshop.all
  end

  # GET /workshops/1
  # GET /workshops/1.json
  def show
    @workshop = Workshop.find(params[:id])
    puts @workshop.inspect
  end

  # GET /workshops/new
  def new
    @workshop = Workshop.new
  end

  def edit 
    @workshop = Workshop.find(params[:id])
  end

  # POST /workshops
  # POST /workshops.json
  def create
    @workshop = current_user.workshops.new(workshop_params)

    respond_to do |format|
      if @workshop.save
        format.html { redirect_to @workshop, notice: 'Workshop was successfully created.' }
        format.json { render :show, status: :created, location: @workshop }
      else
        format.html { render new_users_workshop_path }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workshops/1
  # PATCH/PUT /workshops/1.json
  def update
    @workshop = Workshop.find(params[:id])
    
    respond_to do |format|
      if @workshop.update(workshop_params)
        format.html { redirect_to @workshop, notice: 'Workshop was successfully updated.' }
        format.json { render :show, status: :ok, location: @workshop }
      else
        format.html { render :edit }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshops/1
  # DELETE /workshops/1.json
  def destroy
    @workshop = Workshop.find(params[:id])
    @workshop.destroy
    respond_to do |format|
      format.html { redirect_to users_workshops_url, notice: 'Workshop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  #   # Use callbacks to share common setup or constraints between actions.
    def set_workshop
      @workshop = Workshop.find(params[:id])
    end

  #   # Never trust parameters from the scary internet, only allow the white list through.
    def workshop_params
      params.require(:workshop).permit(:title, :description, :address, :grade, :price, {images: []})
    end
end
