class ProjectsController < ApplicationController

  def index
    @categories = Category.all
    @tags = Tag.all
    @projects = Project.all
    @pledges = Pledge.all
    @rewards = Reward.all

    respond_to do |format|
      format.html
      if params["category"] == 'all'
        format.json {render json: @projects }
      else
        format.json {render json: @projects.where(category_id: params["category"]) }
      end
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
    @project.rewards.build
    @project.tags.build

    @reward = Reward.new
    @category = Category.all
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id

    if @project.save
      redirect_to root_url
    else
      @category = Category.all
      flash[:notice] = "Must enter valid date"
      render :new
    end
  end


  private

  def project_params
    params.require(:project).permit(:title, :description, :startdate,
    :finishdate, :goal,:category_id, rewards_attributes:
    [:description, :price, :_destroy],
    tags_attributes:[:title, :_destroy])
  end


end
