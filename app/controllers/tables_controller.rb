class TablesController < ApplicationController

  get "/tables" do
    erb :'/tables/index'
  end

  get "/tables/:id" do
    #Consider switching to slug for consistency and changing slug method to add on id.
    @table = Table.find(params[:id])
    if @table.public == true
      erb :'/tables/public_show'
    else
      erb :'/sessions/authorization'
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
            params[:public] ? @table.public = true : @table
            @table.save
            flash[:message] = "Table successfully created."
            redirect "/users/#{@user.id}/tables/#{@table.slug}"
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
        @table = Table.find_by_slug(params[:slug], @user)
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
        @table = Table.find_by_slug(params[:slug], @user)
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
        @table = Table.find_by_slug(params[:slug], @user)
        @table.words.each do |word|
          word.update(hebrew: params["hebrew_" + "#{word.id}"], translation_one: params["translation_one_" + "#{word.id}"], translation_two: params["translation_two_" + "#{word.id}"], translation_three: params["translation_three_" + "#{word.id}"])
        end
        params[:public] ? @table.public = true : @table.public = false
        @table.save
        flash[:message] = "Saved."
  			redirect "/users/#{@user.id}/tables/#{@table.slug}"
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
        @table = Table.find_by_slug(params[:slug], @user)
        erb :"/tables/delete_confirmation"
      else
        erb :'/sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end

  delete "/users/:id/tables/:slug" do
    table = Table.find_by_slug(params[:slug], current_user)
    if logged_in?
      if authorized?(table.user_id)
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
