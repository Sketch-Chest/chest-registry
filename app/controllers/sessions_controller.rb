# https://github.com/NoamB/sorcery/wiki/Simple-Password-Authentication

class SessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  def new
    if logged_in?
      # already logged in
      redirect_back_or_to root_path
    else
      # guest user
      @user = User.new
    end
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to root_path, notice: 'You have been logged in successfully.'
    else
      flash[:alert] = 'There was a problem with your email address and/or password. Please try again.'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'You have been logged out.'
  end
end
