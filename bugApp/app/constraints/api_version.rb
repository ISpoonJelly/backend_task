class ApiVersion
  attr_reader :version

  def initialize(options)
    @version = options.fetch(:version)
  end

  def matches?(request)
    request.headers.fetch(:accept).include?("bugapp.v#{@version}")
  end
end
