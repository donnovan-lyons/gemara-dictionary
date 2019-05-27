class SessionsController < ApplicationController

  get '/login' do
    erb :"/sessions/login"
  end

  get '/signup' do
    erb :"/sessions/signup"
  end

  post '/login' do
    @user = User.find_by(username: @user.username)
    redirect "user/#{@user.id}/home"
  end

  post '/sessions' do
    session[:username] = params[:username]
    redirect '/user'
  end

  post "/signup" do
    # binding.pry
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

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
