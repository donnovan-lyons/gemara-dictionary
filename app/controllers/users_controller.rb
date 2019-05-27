class UsersController < ApplicationController

  get "/user" do
    "Welcome #{session[:username]}"
  end

  get '/user/:id/home' do
    @user = User.find(session[:user_id])
    erb :'/users/index'
  end


end
