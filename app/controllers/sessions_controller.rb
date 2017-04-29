class SessionsController < ApplicationController
  def new

  end

  def create
    # Fetch user from db
    user = User.find_by username: params[:username]
    # Save user_id to session
    session[:user_id] = user.id if not user.nil?
    redirect_to user
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
