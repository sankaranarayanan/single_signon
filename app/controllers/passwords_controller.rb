class PasswordsController < ApplicationController
  def new
    @identity = Identity.new
  end

  def create
    identity = Identity.find_by_email(params[:identity][:email])
    if identity
      identity.send_password_reset(omniauth_origin)
      redirect_to signin_form_path, :notice => "Email sent with password reset instructions."
    else
      redirect_to signin_form_path, :notice => "Email not matched with our record"
    end
  end

  def edit
    @identity = Identity.find_by_password_reset_token!(params[:id])
    session[:redirect_uri] = params[:redirect_uri]
  end

  def update
    @identity = Identity.find_by_password_reset_token!(params[:id])
    if @identity.update_attributes(params[:identity])
      session[:user_id] = User.where(email:@identity.email).first.id
      redirect_to session[:redirect_uri] || signin_form_path, :notice => "Password has been reset."
    else
      render :edit
    end
  end
end
