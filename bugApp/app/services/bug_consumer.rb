require 'json'

class BugConsumer
  def initialize()
  end

  def process(message)
    response = true
    @params = ActionController::Parameters.new(JSON.parse(message))

    begin
      ActiveRecord::Base.transaction do
        @state = State.create!(state_params[:state])
        @params[:state_id] = @state.id
        @bug = Bug.create!(bug_params)
      end
    rescue  ActiveRecord::RecordInvalid => invalid
      response = false
    end

    response
  end

  private

  def bug_params
    @params.permit(:appToken, :number, :status, :priority, :comment, :state_id)
  end

  def state_params
    @params.permit(:state => [:device, :os, :memory, :storage])
  end

end
