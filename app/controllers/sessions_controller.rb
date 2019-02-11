class SessionsController < ApplicationController
  def new
    # debugger # Ejercicios 10.2.3
  end
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in @user
      #remember user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      # 10.32 redirect_to @user
      redirect_back_or @user # 10.32
    else
      # Create an error message.
      flash.now[:danger] = 'Combinacion invalida para email/password' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
