class TablesController < ApplicationController

  get "/tables" do
    if logged_in?
      redirect "/users/#{current_user.id}/tables"
    else
      erb :'/sessions/failure'
    end
  end

  get "/tables/new" do
    if logged_in?
      erb :'tables/new'
    else
      erb :'/sessions/failure'
    end
  end

  get "/tables/:slug" do
    if logged_in?
      @table = Table.find_by_slug(params[:slug])
      erb :"/tables/show"
    else
      erb :'/sessions/failure'
    end
  end

  patch "/tables/:id" do
    @table = Table.find(params[:id])
    if logged_in?
      if authorized?(@table.user_id)
        @table.words.each do |word|
          word.update(hebrew: params["hebrew_" + "#{word.id}"], translation_one: params["translation_one_" + "#{word.id}"], translation_two: params["translation_two_" + "#{word.id}"], translation_three: params["translation_three_" + "#{word.id}"])
        end
        flash[:message] = "Saved."
        redirect "/tables/:id"
      else
        erb :'/sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end

  get "/tables/:slug/edit" do
    @table = Table.find_by_slug(params[:slug])
    if logged_in? && authorized?(@table.user_id)
      erb :"tables/edit"
    else
      erb :'/sessions/failure'
    end
  end

  get "/tables/:slug/words/:id/delete" do
    @table = Table.find_by_slug(params[:slug])
    @word = Word.find(params[:id])
    if logged_in?
      if authorized?(@table.user_id)
        erb :"/words/delete_confirmation"
      else
        erb :'/sessions/authorization'
      end
    else
      erb :'/sessions/failure'
    end
  end

  delete "/tables/:slug/words/:id" do
    @table = Table.find_by_slug(params[:slug])
    if logged_in?
      if authorized?(@table.user_id)
        @table = Table.find_by_slug(params[:slug])
        word = Word.find(params[:id])
        @table.delete_word(word)
        flash[:message] = "#{word.hebrew} deleted. "
        redirect "/users/#{current_user.id}/tables/#{@table.slug}/edit"
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
