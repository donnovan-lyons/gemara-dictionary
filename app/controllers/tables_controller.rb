class TablesController < ApplicationController

  get "/tables" do
    #for later integration with User's being able to have public tables. For now, just redirect to user's tables.
    if logged_in?
      redirect "/users/#{current_user.id}/tables"
    else
      erb :'/sessions/failure'
    end
  end

    get "/users/:id/tables" do
      @user = User.find(params[:id])
      if logged_in?
        if authorized?(@user.id)
          erb :'users/tables'
        else
          erb :'/sessions/authorization'
        end
  		else
  			erb :'/sessions/failure'
  		end
    end

    get "/users/:id/tables" do
      @user = User.find(params[:id])
      if logged_in?
        if authorized?(@user.id)
          erb :'users/tables'
        else
          erb :'/sessions/authorization'
        end
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

    post "/users/:id/tables" do
      @user = User.find(params[:id])
      if logged_in?
        if authorized?(@user.id)
          words = Word.parse(params[:section], @user)
          if Table.unique_slug?(params[:title], @user)
            @table = Table.create(title: params[:title], tractate: Tractate.find_by(name: params[:tractate]), words: words, user_id: session[:user_id])
            flash[:message] = "Table successfully created."
            erb :'tables/show'
          else
            flash[:message] = "Please create a unique title for your table."
            redirect "/users/#{@user.id}/tables/new"
          end
        else
          erb :'/sessions/authorization'
        end
      else
        erb :'/sessions/failure'
      end
    end

  get "/users/:id/tables/:slug" do
    @user = User.find(params[:id])
    if logged_in?
      if authorized?(@user.id)
        @table = Table.find_by_slug(params[:slug])
  			erb :"/tables/show"
      else
        erb :'/sessions/authorization'
      end
		else
			erb :'/sessions/failure'
		end
  end

  get '/users/:id/tables/:slug/edit' do
    @user = User.find(params[:id])
    if logged_in?
      if authorized?(@user.id)
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
    @user = User.find(params[:id])
    if logged_in?
      if authorized?(@user.id)
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

  get "/users/:id/tables/:slug/delete" do
    @user = User.find(params[:id])
    if logged_in?
      if authorized?(@user.id)
        @table = Table.find_by_slug(params[:slug])
        erb :"/tables/delete_confirmation"
      else
        erb :'/sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end

  delete "/tables/:slug" do
    table = Table.find_by_slug(params[:slug])
    if logged_in?
      if authorized?(table.user_id)
        table = Table.find_by_slug(params[:slug])
        table.delete_words
        table.delete
        flash[:message] = "#{table.title} deleted."
        redirect "/users/#{current_user.id}/tables"
      else
        erb :'/sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end

end
