class SessionsController < ApplicationController

  def new
  end

  def create
    @baker = Baker.find_by(email: params[:email])
    if @baker && @baker.authenticate(params[:password])
      session[:user_id] = @baker.id
      flash[:welcome] = "Welcome Back #{@baker.name}!"
      redirect_to profile_path
    else
      flash[:invalid] = "Invalid Credentials"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:log_out] = "Successfully Logged out!"
    redirect_to root_path
  end

end
