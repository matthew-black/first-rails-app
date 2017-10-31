class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    unless User.all.count == 0
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
  helper_method :current_user

  def is_matt?
    return false if !current_user
    current_user.id == 1
  end
  helper_method :is_matt?

  def only_for_matt
    redirect_to '/' unless is_matt?
  end

  def authorize
    redirect to '/login' unless current_user
  end

end
