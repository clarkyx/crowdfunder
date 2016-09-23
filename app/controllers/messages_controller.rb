class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  def create
    @types = ['user', 'project'];
    @message = Message.new
    @message.user_id = current_user.id
    if current_user && params["projectinfo"]
      @message.infomation = params["infomation"]
      @message.messagetoid = params["projectinfo"]
      @message.messagetotype = @types[1]
    elsif current_user && params["userinfo"]
      @message.infomation = params["infomation"]
      @message.messagetoid = params["userinfo"]
      @message.messagetotype = @types[0]
    end

    if @message.save!
      respond_to do |format|
        format.html
        format.json{render 'json': @message}
      end
    else
      render :new
    end
  end

end
