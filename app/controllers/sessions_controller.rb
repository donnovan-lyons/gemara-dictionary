class SessionsController < ApplicationController

  get '/login' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :"/sessions/login"
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :"/sessions/signup"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
	    session[:user_id] = @user.id
	    redirect "/users/#{@user.id}"
	  else
	    redirect "/failure"
	  end
  end

  post '/sessions' do
    session[:username] = params[:username]
    redirect '/user'
  end

  post "/signup" do
    user = User.new(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.save
      redirect "/login"
    else
      redirect "/failure"
    end
  end


  get "/failure" do
    erb :'/sessions/failure'
  end

  get "/logout" do
    session.clear
    redirect "/"
  end



end