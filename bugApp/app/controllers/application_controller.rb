class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  def bunny
    BUNNY.direct("amq.direct")
  end
end
