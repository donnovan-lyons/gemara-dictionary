class UsersController < ApplicationController

  get '/users/:id' do
    if logged_in?
			erb :'/users/index'
		else
			erb :'/sessions/failure'
		end
  end

  get "/users/:id/tables/new" do
    if logged_in?
			erb :'tables/new'
		else
			erb :'/sessions/failure'
		end
  end

  get "/users/:id/account" do
    user = User.find(params[:id])
    if logged_in?
      if authorized?(user.id)
        erb :"/users/account"
      else
        erb :'sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end

  patch "/users/:id/account" do
    @user = User.find(params[:id])
    if logged_in?
      if authorized?(@user.id)
        @user = User.find(params[:id])
        @user.update(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
        erb :"/users/account"
      else
        erb :'/sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end

  post "/users/:id/tables" do
    user = User.find(params[:id])
    if logged_in?
      if authorized?(user.id)
        words = Word.parse(params[:section])
        @table = Table.create(title: params[:title], tractate: Tractate.find_by(name: params[:tractate]), words: words, user_id: session[:user_id])
        flash[:message] = "Table successfully created."
        erb :'tables/show'
      else
        erb :'/sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end

  get "/users/:id/tables" do
    user = User.find(params[:id])
    if logged_in?
      if authorized?(user.id)
        erb :'users/tables'
      else
        erb :'/sessions/authorization'
      end
		else
			erb :'/sessions/failure'
		end
  end

  get "/users/:id/tables/:slug" do
    user = User.find(params[:id])
    if logged_in?
      if authorized?(user.id)
        @table = Table.find_by_slug(params[:slug])
  			erb :"/tables/show"
      else
        erb :'/sessions/authorization'
      end
		else
			erb :'/sessions/failure'
		end
  end

  post "/users/:id/tables/:slug" do
    user = User.find(params[:id])
    if logged_in?
      if authorized?(user.id)
        words = Word.parse(params[:section])
        @table = Table.create(title: params[:title], tractate: Tractate.find_by(name: params[:tractate]), words: words, user_id: session[:user_id])
        flash[:message] = "Table successfully created."
        erb :'/tables/show'
      else
        erb :'/sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end

  get '/users/:id/tables/:slug/edit' do
    user = User.find(params[:id])
    if logged_in?
      if authorized?(user.id)
        @table = Table.find_by_slug(params[:slug])
  			erb :"/tables/edit"
      else
        erb :'/sessions/authorization'
      end
		else
			erb :'/sessions/failure'
		end
  end

  patch '/users/:id/tables/:slug' do
    user = User.find(params[:id])
    if logged_in?
      if authorized?(user.id)
        @table = Table.find_by_slug(params[:slug])
        @table.words.each do |word|
          word.update(hebrew: params["hebrew_" + "#{word.id}"], translation_one: params["translation_one_" + "#{word.id}"], translation_two: params["translation_two_" + "#{word.id}"], translation_three: params["translation_three_" + "#{word.id}"])
        end
        flash[:message] = "Saved."
  			erb :"/tables/show"
      else
        erb :'/sessions/authorization'
      end
		else
			erb :'/sessions/failure'
		end
  end

  get "/users/:id/tractates" do
    user = User.find(params[:id])
    if logged_in?
      if authorized?(user.id)
        erb :'users/tractates'
      else
        erb :'/sessions/failure'
      end
		else
			erb :'/sessions/failure'
		end
  end

  get "/users/:id/tables/:slug/delete" do
    user = User.find(params[:id])
    if logged_in?
      if authorized?(user.id)
        @table = Table.find_by_slug(params[:slug])
        erb :"/tables/delete_confirmation"
      else
        erb :'/sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end


 get '/users/:id/tractates/:slug' do
   user = User.find(params[:id])
   if logged_in?
     if authorized?(user.id)
       @tractate = Tractate.find_by_slug(params[:slug])
       erb :"/users/tractates_show"
     else
       erb :'/sessions/authorization'
     end
   else
    erb :'/sessions/failure'
  end
 end

 get "/users/:id/account/delete" do
   user = User.find(params[:id])
   if logged_in?
     if authorized?(user.id)
       erb :'/users/delete_confirmation'
     else
       erb :'/sessions/authorization'
     end
   else
     erb :'/sessions/failure'
   end
 end

   delete "/users/:id/account" do
     user = User.find(params[:id])
     if logged_in?
       if authorized?(user.id)
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
