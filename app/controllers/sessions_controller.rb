class SessionsController < ApplicationController

  get '/login' do
    if logged_in?
      flash[:message] = "You are already logged in."
      redirect "/users/#{current_user.id}"
    else
      erb :"/sessions/login"
    end
  end

  get '/signup' do
    if logged_in?
      flash[:message] = "You are already logged in."
      redirect "/users/#{current_user.id}"
    else
      erb :"/sessions/signup"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
	    session[:user_id] = @user.id
      flash[:message] = "Login successful."
	    redirect "/users/#{@user.id}"
	  else
	    erb :'/sessions/failure'
	  end
  end

  post "/signup" do
    user = User.new(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.save
      flash[:message] = "Signup successful. Please login to continue."
      redirect "/login"
    else
      erb :'/sessions/failure'
    end
  end

  get "/logout" do
    session.clear
    redirect "/"
  end



end
