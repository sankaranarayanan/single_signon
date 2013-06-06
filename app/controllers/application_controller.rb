class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :signin_path

  def omniauth_origin
    request.env['omniauth.origin'] || session['omniauth.origin']
  end

private
  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  end
end
