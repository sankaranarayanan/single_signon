class SessionsController < ApplicationController

  def new
    @identity = Identity.new(env['omniauth.identity'])
    redirect_to(omniauth_origin) and return if current_user
  end

  def create
    auth = Authentication.where(
        :uid => omniauth_uid,
        :provider => omniauth_provider
        ).first_or_initialize
    if auth.new_record?
      auth.user = current_user || User.where(email: omniauth_info[:email]).first_or_create(omniauth_info)
      auth.save
    end
    session[:user_id] = auth.user_id
    redirect_to omniauth_origin || signin_form_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to params[:redirect_uri] || signin_form_path, notice: "Successfully signed out"
  end

  def failure
    redirect_to signin_form_path, notice: "Email already taken. Have you <a href=#{new_password_path}>forgetten password?</a>"
  end

  private

  def authorization_params
    Rack::Utils.parse_query(client_request_params).symbolize_keys
  end

  def client_request_params
    URI.parse(omniauth_origin).query
  end

  def omniauth_uid
    request.env['omniauth.auth']['uid']
  end

  def omniauth_provider
    request.env['omniauth.auth']['provider']
  end

  def omniauth_info
    @omniauth_info ||= request.env['omniauth.auth'][:info].extract!(:email, :name, :image, :location)
  end
end
