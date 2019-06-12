class UsersController < ApplicationController

  get '/users/:id' do
    @user = User.find(params[:id])
    if logged_in?
      if authorized?(@user.id)
        erb :'/users/index'
      else
        erb :'sessions/authorization'
      end
		else
			erb :'/sessions/failure'
		end
  end

  get "/users/:id/account" do
    @user = User.find(params[:id])
    if logged_in?
      if authorized?(@user.id)
        erb :"/users/account"
      else
        erb :'sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end

  patch "/users/:id" do
    @user = User.find(params[:id])
    if logged_in?
      if authorized?(@user.id)
        @user = User.find(params[:id])
        if @user.update(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
          flash[:message] = "Account updated."
          redirect "/users/#{@user.id}/account"
        else
          flash[:message] = "Account updated failed. Please try a unique username and ensure that both passwords fields are correctly filled out."
          redirect "/users/#{@user.id}/account"
        end
      else
        erb :'/sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end

 get "/users/:id/account/delete" do
   @user = User.find(params[:id])
   if logged_in?
     if authorized?(@user.id)
       erb :'/users/delete_confirmation'
     else
       erb :'/sessions/authorization'
     end
   else
     erb :'/sessions/failure'
   end
 end

   delete "/users/:id/account" do
     @user = User.find(params[:id])
     if logged_in?
       if authorized?(@user.id)
         user.delete_all_words_and_tables
         user.delete
         session.clear
         flash[:message] = "User account successfully deleted."
         redirect "/"
       else
         erb :'/sessions/authorization'
       end
     else
       erb :'/sessions/failure'
     end
   end

end
