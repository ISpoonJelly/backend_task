class BugsController < ApplicationController
  before_action :set_bug, only: [:show, :update, :destroy]

  #GET /bugs
  def index
    @bugs = Bug.all
    bug_response(@bugs)
  end

  #GET /bugs/:id?appToken=:appToken
  def show
    bug_response(@bug)
  end

  #POST /bugs
  def create
    @maxnum = Maxnum.find_or_create_by(appToken: params[:appToken])
    @maxnum.max = @maxnum.max + 1
    params[:number] = @maxnum.max

    @state = State.new(state_params[:state])
    @bug = Bug.new(bug_params)
    @bug.state = @state
    @maxnum.save
    post_bug_to_mq(@bug)
    bug_response(@bug, :created)
  end

  #PUT /bugs/:id
  def update
    @bug.update(bug_params)
    head :no_content
  end

  #DELETE /bugs/:id
  def destroy
    @bug.destroy
    head :no_content
  end

  private

  def bug_params
    params.permit(:appToken, :number, :status, :priority, :comment, :state_id)
  end

  def state_params
    params.permit(:state => [:device, :os, :memory, :storage])
  end

  def set_bug
    @bug = Bug.where(number: params[:id], appToken: params[:appToken])
  end

  def post_bug_to_mq(bug)
    bunny.publish(bug_mq_response(bug), :routing_key => 'new_bug')
  end

end
