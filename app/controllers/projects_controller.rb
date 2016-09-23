class ProjectsController < ApplicationController

  def index
    @categories = Category.all
    @tags = Tag.all
    @projects = Project.all
    @pledges = Pledge.all
    @rewards = Reward.all
    @availableprojects = {}
    @fitprojects = []


    if params["taginfo"]
      @tags.where("title LIKE ?", "%#{params["taginfo"]}%").each do |tag|
        @fitprojects << tag.project_id
      end
    end
    @fitprojects.uniq!
    @matchprojects = Project.find(@fitprojects)




    if current_user
      if @matchprojects && params["taginfo"]
        @matchprojects.each do |matproject|
          if current_user.pledges.exists?(project_id: matproject.id)
            @availableprojects[matproject.id] = 'true'
          else
            @availableprojects[matproject.id] = 'false'
          end
        end
      else
        @projects.each do |project|
          if current_user.pledges.exists?(project_id: project.id)
            @availableprojects[project.id] = 'true'
          else
            @availableprojects[project.id] = 'false'
          end
        end
      end


    end

    respond_to do |format|
      format.html
      if current_user && params["category"] == 'all'
        response = {:projectinfo => @projects.where.not(user_id: current_user.id), :pledgedinfo => @availableprojects}
        format.json {render json: response}
      elsif current_user && params["taginfo"]
        response = {:projectinfo => @matchprojects.delete_if{|matchproject|matchproject.user_id == current_user.id},:pledgedinfo => @availableprojects}
        format.json {render json: response}
      elsif current_user
        response = {:projectinfo => @projects.where(category_id: params["category"]).where.not(user_id: current_user.id), :pledgedinfo => @availableprojects}
        format.json {render json: response}
      elsif params["category"] == 'all'
        response = {:projectinfo => @projects, :pledgedinfo => @availableprojects}
        format.json {render json: response}
      elsif params["taginfo"]
        response = {:projectinfo => @matchprojects,:pledgedinfo => @availableprojects}
        format.json {render json: response}
      else
        response = {:projectinfo => @projects.where(category_id: params["category"]), :pledgedinfo => @availableprojects}
        format.json {render json: response}
      end
    end

    if current_user
      @projects = @projects.where.not(user_id: current_user.id)
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
