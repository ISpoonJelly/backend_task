module Response
  def json_response(object, status = :ok)
    render json: object.to_json(:except => [:id, :created_at, :updated_at]),
    status: status
  end

  def bug_response(bug, states = :ok)
    render json: bug.to_json(:except => [:id, :created_at, :updated_at, :state_id],
    :include => { :state => { :except => [:id, :created_at, :updated_at] }}), status: status
  end

  def bug_mq_response(bug)
    bug.to_json(:except => [:id, :created_at, :updated_at, :state_id],
    :include => { :state => { :except => [:id, :created_at, :updated_at] }})
  end
end
