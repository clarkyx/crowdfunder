class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @reward = Reward.new
    @category = Category.all
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id

    if @project.save!
      redirect_to root_url, notice: 'Project created!'
    else
      render :new
    end
  end


  private

  def project_params
    params.require(:project).permit(:title, :description, :deadline,
    :goal,:category_id, rewards_attributes: [:title, :description, :price])
  end


end
