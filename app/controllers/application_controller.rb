class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  rescue_from ActionController::RoutingError, :with => :render_404



  def render_404
    render :template =>"errors/404", :status => 404
  end
  
  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end


end
