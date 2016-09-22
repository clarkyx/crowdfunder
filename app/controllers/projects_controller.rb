class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    @pledges = Pledge.all
    @rewards = Reward.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
    @project.rewards.build

    @reward = Reward.new
    @category = Category.all
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id

    if @project.save
      redirect_to root_url, notice: 'Project created!'
    else
      @category = Category.all
      flash[:notice] = "Enter valid date"
      render :new
    end
  end


  private

  def project_params
    params.require(:project).permit(:title, :description, :startdate,
    :finishdate, :goal,:category_id, rewards_attributes:
    [:title, :description, :price, :_destroy])
  end


end
