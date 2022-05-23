class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_projects, only: [:create, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def new
    if !current_user.manager?
      flash[:alert] = "This action is not permitted"
      redirect_to projects_path
    end
    @project = Project.new
  end

  def create
    @project= current_user.created_projects.new(project_params)
    if @project.save
      flash[:success] = "Project Created"
      redirect_to projects_path
    else
      flash[:alert] = "Ooops, there's some error!"
      redirect_to projects_path
    end
  end

  def edit
  end

  def update
    if !current_user.manager?
      flash[:alert] = "This action is not permitted"
      redirect_to projects_path
    end
    if @project.update(project_params)
      flash[:success] = "Project was updated successfully."
      redirect_to @project
    else
      render "edit"
    end

  end

  def destroy
    @project.destroy
    redirect_to projects_path
    flash[:success] = "Project was deleted successfully."
  end

  def show
  end

  def index
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, user_ids: [])
  end

  def set_projects
    if current_user.manager?||current_user.qa?
      @projects = Project.all
    else
      @projects = current_user.projects
    end
  end

  def set_project
    @project = Project.find_by(id: params[:id])
  end

end
