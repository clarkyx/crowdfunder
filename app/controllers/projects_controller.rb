class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @reward = Reward.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to root_url, notice: 'Project created!'
    else
      render :new
    end
  end


  private

  def project_params
    params.require(:project).permit(:title, :description, :deadline,
    :goal, rewards_attributes: [:title, :description, :price])
  end


end
