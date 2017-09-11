class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:home]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :fetch_project_from_token, only: [:public_share]

  # GET /projects
  # GET /projects.json
  def index
    if(params[:tag])
      @projects = current_user.projects.tagged_with(params[:tag])
    else
      @projects = current_user.projects
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    if(params[:tag])
      @cards = @project.cards.tagged_with(params[:tag])
    else
      @cards = @project.cards
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  def home
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def public_share
    @cards = @project.cards
    render :show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_user.projects.friendly.find(params[:id] || params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :description, :tag_list)
    end

    def fetch_project_from_token
      unless @project = current_user.projects.find_by(public_share_token: params[:token])
        redirect_to root_path, alert: 'The share token is invalid.' and return
      end
    end
end
