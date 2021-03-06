class PledgesController < ApplicationController

  before_filter :load_project
  # before_filter :ensure_logged_in, :only => [:edit, :create, :update, :destroy]
  before_action :set_pledge, only: [:show, :edit, :update, :destroy]

  # GET /pledges
  # GET /pledges.json
  def index
    @pledges = Pledge.all
  end

  # GET /pledges/1
  # GET /pledges/1.json
  def show
    @pledge = Pledge.find(params[:id])
  end

  # GET /pledges/new
  def new
    @pledge = Pledge.new
  end

  # GET /pledges/1/edit
  def edit
  end

  # POST /pledges
  # POST /pledges.json
  def create
    @pledge = @project.pledges.build(pledge_params)
    @pledge.user_id = current_user.id

    respond_to do |format|
      if @pledge.save
        format.html { redirect_to project_pledges_url, notice: 'Pledge was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pledge }
      else
        format.html { render action: 'new' }
        format.json { render json: @pledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pledges/1
  # PATCH/PUT /pledges/1.json
  def update
    respond_to do |format|
      if @pledge.update(pledge_params)
        format.html { redirect_to project_pledges_url, notice: 'Pledge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pledges/1
  # DELETE /pledges/1.json
  def destroy
    @pledge.destroy
    respond_to do |format|
      format.html { redirect_to project_pledges_url, notice: 'Pledge destroyed!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pledge
      @pledge = Pledge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pledge_params
      params.require(:pledge).permit(:project_id, :amount)
    end

    def load_project
      @project = Project.find(params[:project_id])
    end
end
