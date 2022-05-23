class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:new, :create, :show, :index, :edit, :update, :assign_user ]
  before_action :set_bug, only: [:show, :edit, :update, :destroy, :assign_user]

  def new
    if !current_user.qa?
      flash[:alert] = "This action is not permitted"
      redirect_to projects_path
    end
    @bug = @project.bugs.new
  end

  def create
    @bug = @project.bugs.new(bug_params)
    @bug.qa_id = current_user.id
    if @bug.save
      flash[:success] = "Bug Created"
      redirect_to project_bug_path(@project, @bug)
    else
      flash[:alert] = "Something bad happened!"
      redirect_to project_bugs_path
    end
  end

  def assign_user
    @bug = Bug.find_by(id: params[:bug_id])
    if @bug.present?
      @bug.update(user_id: params[:format])
      flash[:success] = "User assigned successfully"
      redirect_to project_bug_path(@project, @bug)
    else
      flash[:alert] = "User assigned successfully"
    end
  end

  def show
  end

  def index
    @bugs = @project.bugs
  end

  def edit
  end

  def update
    if !current_user.qa?
      flash[:alert] = "This action is not permitted"
      redirect_to projects_path
    end
    if @bug.update(bug_params)
      flash[:success] = "Bug was updated successfully."
      redirect_to project_bug_path(@project, @bug)
    else
      render "edit"
    end
  end

  def destroy
    @bug.destroy
    redirect_to project_path
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :description, :screenshot, :start_date, :status, :user_id)
  end

  def set_bug
    @bug = Bug.find_by(id: params[:id])
  end

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end

  def set_bugs
    @bug = Bug.find_by(id: params[:id])
  end
end
