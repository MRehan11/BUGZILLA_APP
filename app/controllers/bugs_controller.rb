class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:new, :create, :show, :index, :edit, :update, :assign_user, :destroy, :update_status ]
  before_action :set_bug, only: [:show, :edit, :update, :destroy, :assign_user, :update_status]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "projects listing", :projects_path


  def new
    add_breadcrumb "project", project_path(@project)
    add_breadcrumb "new bug", new_project_bug_path(@project)
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
      flash[:success] = "Bug added successfully"
      redirect_to project_bug_path(@project, @bug)
    else
      flash[:alert] = @bug.errors.full_messages.to_sentence
      redirect_to project_bugs_path
    end
  end

  def update_status
    @bug = Bug.find_by(id: params[:bug_id])
    if @bug.present?
      @bug.update(status: params[:format].to_i)
      flash[:success] = "Status changed successfully"
      redirect_to project_bug_path(@project, @bug)
    else
      flash[:alert] = "Bug not found"
    end
  end

  def assign_user
    @bug = Bug.find_by(id: params[:bug_id])
    if @bug.present?
      @bug.update(user_id: params[:format])
      flash[:success] = "User assigned successfully"
      redirect_to project_bug_path(@project, @bug)
    else
      flash[:alert] = "Bug not found"
    end
  end

  def show
    add_breadcrumb "project", project_path(@project)
    add_breadcrumb "project bug", :project_bug_path
  end

  def index
    @bugs = @project.bugs
  end

  def edit
    add_breadcrumb "project", project_path(@project)
    add_breadcrumb "edit project", edit_project_bug_path(@project)
  end

  def update
    if @bug.update(bug_params)
      flash[:success] = "Bug was updated successfully."
      redirect_to project_bug_path(@project, @bug)
    else
      flash[:success] = @bug.errors.full_messages
      redirect_to project_bug_path(@project, @bug)
    end
  end

  def destroy
    if @bug.present?
      @bug.destroy
      redirect_to project_path(@project)
      flash[:success] = "Bug deleted successfully"
    else 
      flash[:alert] = "Bug not found"
    end
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
end
