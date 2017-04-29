class SessionsController < ApplicationController
  def new

  end

  def create
    # Fetch user from db
    user = User.find_by username: params[:username]
    # Save user_id to session
    if user.nil?
      redirect_to :back, notice: "User #{params[:username]} does not exist!"
    else
      session[:user_id] = user.id
      redirect_to :root, notice: "Welcome #{params[:username]}!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
