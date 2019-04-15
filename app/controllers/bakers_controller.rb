class BakersController < ApplicationController

  def show
    @baker = current_baker
  end

  def new
    @baker = Baker.new
  end

  def create
    @baker = Baker.new(baker_params)
    if @baker.save
      session[:user_id] = @baker.id
      flash[:welcome] = "Welcome #{@baker.name.capitalize}!"
      redirect_to profile_path
    else
      flash[:notice] = @baker.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def baker_params
    params.require(:baker).permit(:name, :email, :password, :password_confirmation)
  end
  
end
