class SessionsController < ApplicationController
  def new
  end

  def create
    # Fetch user from db
    user = User.find_by username: params[:username]
    # Save user_id to session
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :root, notice: "Welcome #{params[:username]}!"
    else
      redirect_to :back, notice: "Username and/or password incorrect"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
