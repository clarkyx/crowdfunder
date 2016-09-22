class PledgesController < ApplicationController
  def index
    @pledges = Pledge.all
  end

  def create
    @pledge = Pledge.new
    @pledge.user_id = current_user.id
    @pledge.project_id = params['project']
    @pledge.amount = Reward.find_by('id', params['reward']).price

    puts @pledge.project_id
    if @pledge.save!
      respond_to do |format|
        format.html
        format.json
      end
    else
      render :index
    end
  end

end
